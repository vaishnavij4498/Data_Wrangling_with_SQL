# LeetCode Confirmation Rate
SELECT si.user_id, ROUND(IFNULL(AVG(c.action = 'confirmed'), 0), 2) as confirmation_rate
FROM Signups as si
LEFT JOIN Confirmations as c
ON c.user_id = si.user_id
GROUP BY si.user_id
ORDER BY si.user_id
