DROP TABLE IF EXISTS `mod_item_upgrade_weapon_dmg`;
CREATE TABLE `mod_item_upgrade_weapon_dmg`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `stat_mod_pct` float NOT NULL COMMENT '武器伤害提升百分比',
    `stat_rank` smallint unsigned NOT NULL COMMENT '升级rank, 从1开始递增',
    `req_type` tinyint unsigned NOT NULL COMMENT '消耗类型: 1=金币 2=荣誉 3=竞技场点 4=道具 5=无消耗',
    `req_val1` float NOT NULL COMMENT '消耗数值1 (金币/点数单位, 或道具entry)',
    `req_val2` float DEFAULT NULL COMMENT '消耗数值2 (道具数量, 当req_type=4时使用)',
    `success_chance` float NOT NULL DEFAULT 100.0 COMMENT '成功率 0-100, 100=必定成功',
    PRIMARY KEY (`id`),
    KEY `idx_stat_rank` (`stat_rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 武器伤害升级阶梯: rank 1=5%, rank 2=10%, rank 3=15%
-- 后续 Tier 2/3 的 rank 4-9 也需要补充
INSERT INTO `mod_item_upgrade_weapon_dmg` (`stat_mod_pct`, `stat_rank`, `req_type`, `req_val1`, `req_val2`, `success_chance`) VALUES
(5,  1, 1, 10000000, NULL, 100),
(10, 2, 1, 20000000, NULL, 100),
(15, 3, 1, 30000000, NULL, 100),
(20, 4, 1, 40000000, NULL, 100),
(25, 5, 1, 50000000, NULL, 100),
(30, 6, 1, 60000000, NULL, 100),
(35, 7, 1, 70000000, NULL, 100),
(40, 8, 1, 80000000, NULL, 100),
(45, 9, 1, 90000000, NULL, 100);
