-- 攻速线通用段调价（2026-09-08，用户定：9 档升满期望 ~10 万金）
-- 单价 500x档序 → 800x档序（800/1600/2400/3200/4000/4800/5600/6400/7200，标价合计 3.6 万）
-- 成功率 100→20 不动，期望花费 = Σ(800r/成功率) ≈ 9.77 万
-- 原地 UPDATE：id 不变（character 数据按 id 引用，禁止 DELETE 重插改 id）
UPDATE `mod_item_upgrade_weapon_spd` SET `req_val1` = 8000000 * `stat_rank` WHERE `stat_rank` BETWEEN 1 AND 9;
