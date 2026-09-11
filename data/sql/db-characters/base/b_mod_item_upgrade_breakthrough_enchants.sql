DROP TABLE IF EXISTS `mod_item_upgrade_breakthrough_enchants`;
CREATE TABLE `mod_item_upgrade_breakthrough_enchants`(
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `tier` tinyint unsigned NOT NULL COMMENT '品阶号, 对应全局 tier 行',
    `match_stat` int unsigned NOT NULL COMMENT '匹配属性类型(ItemModType), 装备模板含此属性即命中',
    `enchant_id` int unsigned NOT NULL COMMENT '命中后发放的词条(SpellItemEnchantment)',
    `priority` int NOT NULL DEFAULT 0 COMMENT '多条命中取最高, 同值取 id 小者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 通用装备突破词条分流规则(全局 tier 行): 装备模板含 match_stat 即命中, 多条取 priority 最高
-- tier2: 45/5/6->4651(+25法强/+10暴), 12-15->4652(+12防御/+10耐), 3->4650(+10敏/+8暴), 4->4657(+10力/+8暴)
-- tier3: 45/5/6->4655(+50法强/+16暴), 12-15->4656(+22防御/+20耐), 3->4654(+20敏/+12暴), 4->4658(+20力/+12暴)
INSERT INTO `mod_item_upgrade_breakthrough_enchants` (`id`, `tier`, `match_stat`, `enchant_id`, `priority`) VALUES
(1, 2, 45, 4651, 100),
(2, 2, 12, 4652, 90),
(3, 2, 13, 4652, 90),
(4, 2, 14, 4652, 90),
(5, 2, 15, 4652, 90),
(6, 2, 3, 4650, 85),
(7, 2, 5, 4651, 80),
(8, 2, 6, 4651, 75),
(9, 2, 4, 4657, 70),
(10, 3, 45, 4655, 100),
(11, 3, 12, 4656, 90),
(12, 3, 13, 4656, 90),
(13, 3, 14, 4656, 90),
(14, 3, 15, 4656, 90),
(15, 3, 3, 4654, 85),
(16, 3, 5, 4655, 80),
(17, 3, 6, 4655, 75),
(18, 3, 4, 4658, 70);
