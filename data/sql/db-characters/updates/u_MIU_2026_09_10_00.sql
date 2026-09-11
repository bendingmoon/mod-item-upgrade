-- ============================================================
-- 通用装备突破词条分流 (2026-09-10, var/gen_breakthrough_enchant_sql.py)
-- 全局 tier 行(item_entry=0)的突破词条按装备模板属性自动匹配流派:
-- 含 match_stat 即命中, 多条取 priority 最高(同值取 id 小者),
-- 无命中回落 tiers 行自身 breakthrough_enchant_id(保底)。专属行不走本表。
-- ============================================================

CREATE TABLE IF NOT EXISTS `mod_item_upgrade_breakthrough_enchants`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `tier` tinyint unsigned NOT NULL COMMENT '品阶号, 对应全局 tier 行',
    `match_stat` int unsigned NOT NULL COMMENT '匹配属性类型(ItemModType), 装备模板含此属性即命中',
    `enchant_id` int unsigned NOT NULL COMMENT '命中后发放的词条(SpellItemEnchantment)',
    `priority` int NOT NULL DEFAULT 0 COMMENT '多条命中取最高, 同值取 id 小者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tier2/tier3 分流规则各 9 行(敏>智兜猎人, 防>力/智兜防战防骑); 力量系镜像敏捷系
DELETE FROM `mod_item_upgrade_breakthrough_enchants` WHERE `id` BETWEEN 1 AND 18;
INSERT INTO `mod_item_upgrade_breakthrough_enchants` (`id`, `tier`, `match_stat`, `enchant_id`, `priority`) VALUES
(1, 2, 45, 4651, 100),
(2, 2, 12, 4652, 90),
(3, 2, 13, 4652, 90),
(4, 2, 14, 4652, 90),
(5, 2, 15, 4652, 90),
(6, 2, 3, 4650, 85),
(7, 2, 5, 4651, 80),
(8, 2, 6, 4651, 75),
(9, 2, 4, 4657, 70),
(10, 3, 45, 4655, 100),
(11, 3, 12, 4656, 90),
(12, 3, 13, 4656, 90),
(13, 3, 14, 4656, 90),
(14, 3, 15, 4656, 90),
(15, 3, 3, 4654, 85),
(16, 3, 5, 4655, 80),
(17, 3, 6, 4655, 75),
(18, 3, 4, 4658, 70);

-- 保底词条: 全局 tier2 3861(+20力量) -> 4653(+5全属性); tier3 3879(+10全属性)不动
UPDATE `mod_item_upgrade_tiers` SET `breakthrough_enchant_id` = 4653 WHERE `item_entry` = 0 AND `tier` = 2;
