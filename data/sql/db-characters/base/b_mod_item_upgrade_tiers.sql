DROP TABLE IF EXISTS `mod_item_upgrade_tiers`;
CREATE TABLE `mod_item_upgrade_tiers`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `item_entry` int unsigned NOT NULL DEFAULT 0 COMMENT '0=全局默认, 非0=特定装备覆写',
    `tier` tinyint unsigned NOT NULL COMMENT 'Tier编号: 1,2,3...',
    `name` varchar(255) NOT NULL COMMENT 'Tier名称, 如"精良"/"史诗"',
    `begin_rank` smallint unsigned NOT NULL COMMENT '该Tier的起始rank (属性/武器伤害/武器攻速共用)',
    `end_rank` smallint unsigned NOT NULL COMMENT '该Tier的结束rank',
    `breakthrough_cost_type` tinyint unsigned NOT NULL COMMENT '突破消耗类型: 1=金币 2=荣誉 3=竞技场点 4=道具',
    `breakthrough_cost_val1` float NOT NULL COMMENT '突破消耗数值1 (金币/点数单位, 或道具entry)',
    `breakthrough_cost_val2` float DEFAULT NULL COMMENT '突破消耗数值2 (道具数量, 当cost_type=4时使用)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_item_tier` (`item_entry`, `tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `mod_item_upgrade_tiers` (`item_entry`, `tier`, `name`, `begin_rank`, `end_rank`, `breakthrough_cost_type`, `breakthrough_cost_val1`, `breakthrough_cost_val2`) VALUES
(0, 1, '精良', 1, 3, 1, 50000000, NULL),
(0, 2, '史诗', 4, 6, 1, 100000000, NULL),
(0, 3, '传说', 7, 9, 1, 200000000, NULL);
