DROP TABLE IF EXISTS `mod_item_upgrade_stats`;
CREATE TABLE `mod_item_upgrade_stats`(
	`id` int unsigned not null,
    `stat_type` tinyint unsigned NOT NULL,
    `stat_mod_pct` float not null,
    `stat_rank` smallint unsigned NOT NULL,
    `success_chance` float NOT NULL DEFAULT 100.0 COMMENT '成功率 0-100, 100=必定成功',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (1, 3, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (2, 4, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (3, 5, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (4, 6, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (5, 7, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (6, 32, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (7, 36, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (8, 45, 5, 1, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (9, 3, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (10, 4, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (11, 5, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (12, 6, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (13, 7, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (14, 32, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (15, 36, 10, 2, 100);
INSERT INTO `mod_item_upgrade_stats` (`id`, `stat_type`, `stat_mod_pct`, `stat_rank`, `success_chance`) VALUES (16, 45, 10, 2, 100);