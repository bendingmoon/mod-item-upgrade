DROP TABLE IF EXISTS `mod_item_upgrade_tiers`;
CREATE TABLE `mod_item_upgrade_tiers`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `item_entry` int unsigned NOT NULL DEFAULT 0 COMMENT '0=全局默认, 非0=特定装备覆写',
    `tier` tinyint unsigned NOT NULL COMMENT 'Tier编号: 1,2,3...',
    `name` varchar(255) NOT NULL COMMENT 'Tier名称, 如"精良"/"史诗"',
    `begin_rank` smallint unsigned NOT NULL COMMENT '该Tier的起始rank (属性/武器伤害/武器攻速共用)',
    `end_rank` smallint unsigned NOT NULL COMMENT '该Tier的结束rank',
    `breakthrough_costs` text DEFAULT NULL COMMENT '突破消耗, 格式: type:val1:val2|type:val1:val2, 例: 1:50000000:0|4:12345:3|4:67890:5',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_item_tier` (`item_entry`, `tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `mod_item_upgrade_tiers` (`item_entry`, `tier`, `name`, `begin_rank`, `end_rank`, `breakthrough_costs`) VALUES
(0, 1, '精良', 1, 3, '1:50000000:0'),
(0, 2, '史诗', 4, 6, '1:100000000:0'),
(0, 3, '传说', 7, 9, '1:200000000:0');
