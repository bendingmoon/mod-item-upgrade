/*
 * Credits: silviu20092
 */

#include "ScriptMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "ObjectAccessor.h"
#include "item_upgrade.h"

using namespace Acore::ChatCommands;

class item_upgrade_commandscript : public CommandScript
{
private:
    static std::unordered_map<uint32, uint32> cmdListUpgradesTimerMap;
    static constexpr uint32 listUpgradesDiffTimer = 10000;
public:
    item_upgrade_commandscript() : CommandScript("item_upgrade_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable itemUpgradeSubcommandTable =
        {
            { "reload", HandleReloadModItemUpgrade, SEC_ADMINISTRATOR, Console::Yes },
            { "lock",   HandleLockItemUpgrade,      SEC_ADMINISTRATOR, Console::Yes },
            { "max",    HandleMaxItemUpgrade,       SEC_ADMINISTRATOR, Console::Yes },
            { "list",   HandleListUpgrades,         SEC_PLAYER,        Console::No  }
        };

        static ChatCommandTable itemUpgradeCommandTable =
        {
            { "item_upgrade", itemUpgradeSubcommandTable }
        };

        return itemUpgradeCommandTable;
    }
private:
    static bool HandleReloadModItemUpgrade(ChatHandler* handler)
    {
        ItemUpgrade::PagedDataMap& pagedData = sItemUpgrade->GetPagedDataMap();
        for (auto& itr : pagedData)
            itr.second.reloaded = true;

        sItemUpgrade->SetReloading(true);
        sItemUpgrade->HandleDataReload(false);

        sItemUpgrade->LoadFromDB(true);

        sItemUpgrade->HandleDataReload(true);
        sItemUpgrade->SetReloading(false);

        handler->SendGlobalGMSysMessage("Item Upgrade module data successfully reloaded.");
        return true;
    }

    // .item_upgrade max <玩家名> <装备槽0-18> — 指定槽位装备免费直升到最顶级（不扣金币/材料，不 roll 成功率）
    static bool HandleMaxItemUpgrade(ChatHandler* handler, std::string playerName, uint32 slot)
    {
        Player* player = ObjectAccessor::FindPlayerByName(playerName, false);
        if (!player)
        {
            handler->PSendSysMessage("玩家 {} 不在线（该命令仅支持在线玩家）。", playerName);
            return true;
        }

        if (slot >= EQUIPMENT_SLOT_END)
        {
            handler->PSendSysMessage("槽位 {} 无效，范围 0-{}。", slot, uint32(EQUIPMENT_SLOT_END - 1));
            return true;
        }

        Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (!item)
        {
            handler->PSendSysMessage("玩家 {} 的槽位 {}（{}）上没有装备。", playerName, slot,
                ItemUpgrade::EquipmentSlotToString((EquipmentSlots)slot));
            return true;
        }

        uint8 maxTier = sItemUpgrade->GetMaxTierNum(item->GetEntry());
        uint8 tier = sItemUpgrade->MaxOutItem(player, item);
        if (tier == 0)
        {
            handler->PSendSysMessage("{} 不支持升级（不在白名单/被拉黑，或无可升级项）。",
                ItemUpgrade::ItemLink(player, item));
            return true;
        }

        if (tier < maxTier)
            handler->PSendSysMessage("{} 已升至品阶 {}，但未达最顶级 {}（阶梯缺档导致突破中断，检查配置）。",
                ItemUpgrade::ItemLink(player, item), tier, maxTier);
        else
            handler->PSendSysMessage("{} 已直升到最顶级（品阶 {}/{}）。",
                ItemUpgrade::ItemLink(player, item), tier, maxTier);
        return true;
    }

    static bool HandleLockItemUpgrade(ChatHandler* handler)
    {
        sItemUpgrade->SetReloading(true);
        handler->SendSysMessage("Item Upgrade NPC is now locked, it is now safe to edit database tables. Release the lock by using .item_upgrade reload command");
        return true;
    }

    static bool HandleListUpgrades(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
            target = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!target)
            return false;

        Player* player = target->GetConnectedPlayer();

        uint32 currentTime = getMSTime();
        uint32 lastTime = cmdListUpgradesTimerMap[player->GetGUID().GetCounter()];
        uint32 diff = getMSTimeDiff(lastTime, currentTime);
        if (lastTime > 0 && diff < listUpgradesDiffTimer)
        {
            handler->PSendSysMessage("Please try again in {} seconds.", (listUpgradesDiffTimer - diff) / 1000);
            return true;
        }
        cmdListUpgradesTimerMap[player->GetGUID().GetCounter()] = currentTime;

        uint32 upgradedItems = 0;
        uint32 upgradedStats = 0;
        uint32 weaponUpgrades = 0;
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        {
            if (const Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                std::vector<const ItemUpgrade::UpgradeStat*> upgrades = sItemUpgrade->FindUpgradesForItem(player, item);
                const ItemUpgrade::UpgradeStat* weaponUpgrade = sItemUpgrade->FindUpgradeForWeaponDamage(player, item);
                const ItemUpgrade::UpgradeStat* weaponSpeedUpgrade = sItemUpgrade->FindUpgradeForWeaponSpeed(player, item);

                if (!upgrades.empty() || weaponUpgrade != nullptr || weaponSpeedUpgrade != nullptr)
                {
                    upgradedItems++;
                    std::string slot = ItemUpgrade::EquipmentSlotToString((EquipmentSlots)i);
                    handler->PSendSysMessage("{} [{}]", ItemUpgrade::ItemLink(player, item), slot);
                    if (!upgrades.empty())
                    {
                        upgradedStats += upgrades.size();
                        std::vector<_ItemStat> statInfo = ItemUpgrade::LoadItemStatInfo(item);
                        handler->PSendSysMessage("Found {} stat upgrades:", upgrades.size());
                        for (const auto* stat : upgrades)
                        {
                            const _ItemStat* foundStat = ItemUpgrade::GetStatByType(statInfo, stat->statType);
                            ASSERT(foundStat != nullptr);
                            std::ostringstream oss;
                            oss << "|cffb50505" << foundStat->ItemStatValue << "|r --> ";
                            oss << "|cff056e3a" << ItemUpgrade::CalculateModPct(foundStat->ItemStatValue, stat) << "|r";
                            std::ostringstream statusOss;
                            if (sItemUpgrade->IsInactiveStatUpgrade(item, stat))
                                statusOss << "|cffb50505INACTIVE|r";
                            else
                                statusOss << "|cff056e3aACTIVE|r";
                            handler->PSendSysMessage("{} increased by {}% [RANK {}] [{}] [{}]", ItemUpgrade::StatTypeToString(stat->statType), stat->statModPct, stat->statRank, oss.str(), statusOss.str());
                        }
                    }
                    if (weaponUpgrade != nullptr)
                    {
                        weaponUpgrades++;
                        std::pair<float, float> dmgInfo = ItemUpgrade::GetItemProtoDamage(item);
                        float upgradedMinDamage = std::floor(ItemUpgrade::CalculateModPctF(dmgInfo.first, weaponUpgrade));
                        float upgradedMaxDamage = std::ceil(ItemUpgrade::CalculateModPctF(dmgInfo.second, weaponUpgrade));

                        std::ostringstream statusOss;
                        if (sItemUpgrade->IsInactiveWeaponUpgrade())
                            statusOss << "|cffb50505INACTIVE|r";
                        else
                            statusOss << "|cff056e3aACTIVE|r";

                        handler->PSendSysMessage("This weapon is upgraded by {}%, [MIN DAMAGE {}], [MAX DAMAGE {}] [{}]",
                            ItemUpgrade::FormatFloat(weaponUpgrade->statModPct),
                            ItemUpgrade::FormatIncrease(dmgInfo.first, upgradedMinDamage),
                            ItemUpgrade::FormatIncrease(dmgInfo.second, upgradedMaxDamage),
                            statusOss.str());
                    }
                    if (weaponSpeedUpgrade != nullptr)
                    {
                        if (weaponUpgrade == nullptr)
                            weaponUpgrades++;

                        uint32 originalDelay = ItemUpgrade::GetItemProtoDelay(item);
                        uint32 newDelay = sItemUpgrade->HandleWeaponSpeedModifier(player, item);

                        std::ostringstream statusOss;
                        if (sItemUpgrade->IsInactiveWeaponSpeedUpgrade())
                            statusOss << "|cffb50505INACTIVE|r";
                        else
                            statusOss << "|cff056e3aACTIVE|r";

                        handler->PSendSysMessage("This weapon's speed is upgraded by {}%, [ORIGINAL SPEED {}] [NEW SPEED {}] [{}]",
                            ItemUpgrade::FormatFloat(weaponSpeedUpgrade->statModPct),
                            ItemUpgrade::FormatDelay(originalDelay),
                            ItemUpgrade::FormatDelay(newDelay),
                            statusOss.str());
                    }
                    handler->SendSysMessage("--------------- NEXT ITEM OR END ---------------");
                }
            }
        }

        if (upgradedItems == 0 && weaponUpgrades == 0)
            handler->PSendSysMessage("{} does not have any upgrades.", player->GetPlayerName());
        else
            handler->PSendSysMessage("{} has a total of: {} upgraded item(s), {} upgraded stat(s), {} upgraded weapon(s).", player->GetPlayerName(), upgradedItems, upgradedStats, weaponUpgrades);

        return true;
    }
};

std::unordered_map<uint32, uint32> item_upgrade_commandscript::cmdListUpgradesTimerMap;

void AddSC_item_upgrade_commandscript()
{
    new item_upgrade_commandscript();
}
