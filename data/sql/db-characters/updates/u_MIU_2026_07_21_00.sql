ALTER TABLE `mod_item_upgrade_tiers`
    ADD COLUMN `breakthrough_enchant_id` int unsigned NOT NULL DEFAULT 0 COMMENT '突破到该Tier后奖励的词条附魔ID (SpellItemEnchantment), 0=无' AFTER `breakthrough_costs`;
