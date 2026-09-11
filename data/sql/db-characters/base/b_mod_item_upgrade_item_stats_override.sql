DROP TABLE IF EXISTS `mod_item_upgrade_item_stats_override`;
CREATE TABLE `mod_item_upgrade_item_stats_override`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `item_entry` int unsigned NOT NULL COMMENT '装备 entry',
    `stat_type` int unsigned NOT NULL COMMENT '该装备额外允许升级的属性类型(ItemModType, 全局 AllowedStats 之外)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_entry_stat` (`item_entry`, `stat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 按装备属性覆盖: 该装备额外允许升级的属性类型(全局 AllowedStats=3,4,5,6,7,32,36,45 之外)
-- 当前: 57009=43法回, 57010=38攻强/44甲穿, 57011=12防御/13躲闪/15格挡
INSERT INTO `mod_item_upgrade_item_stats_override` (`id`, `item_entry`, `stat_type`) VALUES
(1, 57009, 43),
(2, 57010, 38),
(3, 57010, 44),
(4, 57011, 12),
(5, 57011, 13),
(6, 57011, 15);
