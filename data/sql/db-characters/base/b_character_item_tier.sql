DROP TABLE IF EXISTS `character_item_tier`;
CREATE TABLE `character_item_tier`(
    `guid` int unsigned NOT NULL COMMENT '玩家角色GUID',
    `item_guid` int unsigned NOT NULL COMMENT '物品GUID',
    `tier` tinyint unsigned NOT NULL DEFAULT 1 COMMENT '当前所处Tier编号',
    PRIMARY KEY (`guid`, `item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
