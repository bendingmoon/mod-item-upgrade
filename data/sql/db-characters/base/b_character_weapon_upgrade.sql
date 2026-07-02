DROP TABLE IF EXISTS `character_weapon_upgrade`;
CREATE TABLE `character_weapon_upgrade`(
	`guid` int unsigned not null,
	`item_guid` int unsigned not null,
    `stat_rank` smallint unsigned NOT NULL COMMENT '武器伤害当前升级rank',
    PRIMARY KEY (`guid`, `item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;