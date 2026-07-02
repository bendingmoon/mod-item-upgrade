-- ============================================================
-- Tier 等级制改造 - Phase 1 数据库变更
--
-- 新增表 (base 文件已处理):
--   mod_item_upgrade_tiers, mod_item_upgrade_weapon_dmg,
--   mod_item_upgrade_weapon_spd, character_item_tier
-- 修改表 (base 文件已处理):
--   character_weapon_upgrade, character_weapon_speed_upgrade
--   (upgrade_perc float → stat_rank smallint unsigned)
-- ============================================================

-- 给 mod_item_upgrade_stats 添加 stat_rank 索引
-- 用于 Tier 范围查询: WHERE stat_rank BETWEEN begin_rank AND end_rank
ALTER TABLE `mod_item_upgrade_stats` ADD KEY `idx_stat_rank` (`stat_rank`);
