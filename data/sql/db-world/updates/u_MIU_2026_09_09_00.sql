-- ============================================================
-- 橙杖不朽词条数值加强 (2026-09-09, 用户定案)
--   4631 橙杖法(22589) tier7: +225法强/+25暴/+20急速 -> +300法强/+100暴/+100急速 (同步术士)
--   4637 橙杖术(22630) tier7: +225法强/+20暴/+25急速 -> +300法强/+100暴/+100急速
--   4643 橙杖牧(22631) tier7: +225法强/+25精/+20耐  -> +300法强/+100精/+100耐
-- 已持有这三条词条的玩家自动获得新数值(装备存词条 ID, 生效时按定义现算), 无需迁移。
-- 注: 橙杖满配法强锚点 K6 从 375 上调为 450 (裸装 150 + 词条 300)。
-- ============================================================

DELETE FROM `spellitemenchantment_dbc` WHERE `ID` IN (4631, 4637, 4643);
INSERT INTO `spellitemenchantment_dbc` (`ID`, `Charges`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectPointsMin_1`, `EffectPointsMin_2`, `EffectPointsMin_3`, `EffectPointsMax_1`, `EffectPointsMax_2`, `EffectPointsMax_3`, `EffectArg_1`, `EffectArg_2`, `EffectArg_3`, `Name_Lang_deDE`, `Name_Lang_Mask`) VALUES
(4631, 0, 5, 5, 5, 300, 100, 100, 300, 100, 100, 45, 32, 36, '不朽·守护者之力:+300 法术强度/+100 爆击/+100 急速', 16712190),
(4637, 0, 5, 5, 5, 300, 100, 100, 300, 100, 100, 45, 32, 36, '不朽·守护者之力:+300 法术强度/+100 爆击/+100 急速', 16712190),
(4643, 0, 5, 5, 5, 300, 100, 100, 300, 100, 100, 45, 6, 7, '不朽·守护者之力:+300 法术强度/+100 精神/+100 耐力', 16712190);

-- ----------------------------------------------------------
-- 风剑/橙锤 tier7 不朽词条属性加强 (2026-09-09, 用户圈改; proc 不动)
--   4619 风剑: 属性包法术 100103 -> +38敏/+58耐/+21命中
--   4625 橙锤: 属性包法术 100105 -> +80力/+58耐/+38暴
-- ----------------------------------------------------------
DELETE FROM `spell_dbc` WHERE `ID` = 100103;
INSERT INTO `spell_dbc` VALUES (100103, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 6, 6, 1, 1, 1, 0, 0, 0, 37, 57, 20, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 29, 29, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Zephyr Force', NULL, NULL, NULL, '逐风者之力', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `spell_dbc` WHERE `ID` = 100105;
INSERT INTO `spell_dbc` VALUES (100105, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 6, 6, 1, 1, 1, 0, 0, 0, 79, 57, 37, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 29, 29, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1792, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Flame Lord Force', NULL, NULL, NULL, '炎魔之力', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712190, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16712188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `spellitemenchantment_dbc` WHERE `ID` IN (4619, 4625);
INSERT INTO `spellitemenchantment_dbc` (`ID`, `Charges`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectPointsMin_1`, `EffectPointsMin_2`, `EffectPointsMin_3`, `EffectPointsMax_1`, `EffectPointsMax_2`, `EffectPointsMax_3`, `EffectArg_1`, `EffectArg_2`, `EffectArg_3`, `Name_Lang_deDE`, `Name_Lang_Mask`) VALUES
(4619, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 100103, 100104, 0, '不朽·逐风者之怒:+38 敏捷/+58 耐力/+21 命中,攻击时可能施放雷霆万钧', 16712190),
(4625, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 100105, 100106, 0, '不朽·炎魔之王:+80 力量/+58 耐力/+38 爆击,攻击时可能施放焚天怒火', 16712190);
