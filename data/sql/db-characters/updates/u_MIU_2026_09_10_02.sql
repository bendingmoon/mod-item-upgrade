-- ============================================================
-- 基础装备属性比例减半 + 武器线金价单位修复 (2026-09-10, 用户定案)
-- 金币/突破材料不减半保持原样(深夜修订); var/gen_breakthrough_enchant_sql.py 生成
-- 影响面: 已购属性记录 pct 随新曲线(5R%->2.5R%, nerf 用户已确认);
--         橙装段(rank10-72)/饰品段(rank73-81)/橙装 tier 与词条 不动
-- ============================================================

-- 1. 属性线 rank1-9: 比例 5%/档 -> 2.5%/档 (金币/成功率不变)
UPDATE `mod_item_upgrade_stats` SET `stat_mod_pct` = 2.5 * `stat_rank` WHERE `stat_rank` BETWEEN 1 AND 9;

-- 2. 武器伤害/攻速通用段金价单位修复 (09-07 少乘 10000 的 bug): 恢复设计价
--    伤害 500x档序 金 = 5000000x档序 铜; 攻速 800x档序 金 = 8000000x档序 铜; 比例不动
UPDATE `mod_item_upgrade_weapon_dmg` SET `req_val1` = 500 * `stat_rank` * 10000 WHERE `stat_rank` BETWEEN 1 AND 9;
UPDATE `mod_item_upgrade_weapon_spd` SET `req_val1` = 800 * `stat_rank` * 10000 WHERE `stat_rank` BETWEEN 1 AND 9;
