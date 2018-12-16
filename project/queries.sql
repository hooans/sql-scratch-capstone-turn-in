2.1
SELECT * FROM survey LIMIT 10;

2.2
SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY question;

3.1
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
LIMIT 10;

3.2
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
LIMIT 10;

3.3
WITH funnels AS (
  SELECT DISTINCT q.user_id,
     h.number_of_pairs,
     h.user_id IS NOT NULL AS 'is_home_try_on',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
    ON q.user_id = h.user_id
  LEFT JOIN purchase p
    ON p.user_id = q.user_id)
SELECT COUNT(*) AS 'Quiz Takers', 
  SUM(is_home_try_on) AS 'Tried at home',
  SUM(is_purchase) AS 'Purchased',
  1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'q>h conversion',
  1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'h>p conversion'
FROM funnels;

3.4.1
WITH funnels AS (
  SELECT DISTINCT q.user_id,
     h.number_of_pairs,
     h.user_id IS NOT NULL AS 'is_home_try_on',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
    ON q.user_id = h.user_id
  LEFT JOIN purchase p
    ON p.user_id = q.user_id
    WHERE h.number_of_pairs = '3 pairs')
SELECT 
    SUM(is_home_try_on) AS '3 Pairs',
    SUM(is_purchase) AS 'Purchased',
    1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'h>p Conversion'
FROM funnels;



3.4.2
WITH funnels AS (
  SELECT DISTINCT q.user_id,
     h.number_of_pairs,
     h.user_id IS NOT NULL AS 'is_home_try_on',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
    ON q.user_id = h.user_id
  LEFT JOIN purchase p
    ON p.user_id = q.user_id
    WHERE h.number_of_pairs = '5 pairs')
SELECT 
    SUM(is_home_try_on) AS '5 Pairs',
    SUM(is_purchase) AS 'Purchased',
    1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'h>p Conversion'
FROM funnels;

4.1
SELECT style AS Style,  COUNT(*) AS Amount
FROM quiz
GROUP BY Style
ORDER by Amount DESC;

4.2
SELECT shape AS Shape, COUNT(*) AS Amount
FROM quiz
GROUP BY Shape
ORDER by Amount DESC;