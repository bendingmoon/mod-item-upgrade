DROP TABLE IF EXISTS `mod_item_upgrade_weapon_spd`;
CREATE TABLE `mod_item_upgrade_weapon_spd`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `stat_mod_pct` float NOT NULL COMMENT '武器攻速提升百分比',
    `stat_rank` smallint unsigned NOT NULL COMMENT '升级rank, 从1开始递增',
    `req_type` tinyint unsigned NOT NULL COMMENT '消耗类型: 1=金币 2=荣誉 3=竞技场点 4=道具 5=无消耗',
    `req_val1` float NOT NULL COMMENT '消耗数值1 (金币/点数单位, 或道具entry)',
    `req_val2` float DEFAULT NULL COMMENT '消耗数值2 (道具数量, 当req_type=4时使用)',
    PRIMARY KEY (`id`),
    KEY `idx_stat_rank` (`stat_rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 武器攻速升级阶梯: rank 1=10%, rank 2=20%, rank 3=30%
INSERT INTO `mod_item_upgrade_weapon_spd` (`stat_mod_pct`, `stat_rank`, `req_type`, `req_val1`, `req_val2`) VALUES
(10, 1, 1, 15000000, NULL),
(20, 2, 1, 30000000, NULL),
(30, 3, 1, 45000000, NULL),
(40, 4, 1, 60000000, NULL),
(50, 5, 1, 75000000, NULL),
(60, 6, 1, 90000000, NULL),
(70, 7, 1, 105000000, NULL),
(80, 8, 1, 120000000, NULL),
(90, 9, 1, 135000000, NULL);
