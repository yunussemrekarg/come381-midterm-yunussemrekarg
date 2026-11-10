-- BÖLÜM D: İLİŞKİSEL CEBİR SORGULARI

-- D1: 1 Aralık 2026 tarihindeki planlanmış seanslar
SELECT DISTINCT session_date, start_time, capacity
FROM training_session
WHERE session_date = '2026-12-01'
  AND status = 'scheduled';


-- D2: Üyelerin katıldığı seanslar
SELECT DISTINCT m.first_name, m.last_name, ts.session_date
FROM member m
JOIN session_registration sr ON m.member_id = sr.member_id
JOIN training_session ts ON sr.session_id = ts.session_id;


-- D3: Hem fitness hem wellness seanslarına katılan üyeler
SELECT member_id
FROM (
    SELECT DISTINCT sr.member_id
    FROM session_registration sr
    JOIN training_session ts ON sr.session_id = ts.session_id
    WHERE ts.category = 'fitness'

    INTERSECT

    SELECT DISTINCT sr.member_id
    FROM session_registration sr
    JOIN training_session ts ON sr.session_id = ts.session_id
    WHERE ts.category = 'wellness'
) AS common_members;


-- D4A: Hiçbir seansa kayıt olmayan üyeler (EXCEPT)
SELECT member_id, first_name, last_name
FROM member
WHERE member_id IN (
    SELECT member_id FROM member
    EXCEPT
    SELECT member_id FROM session_registration
);


-- D4B: Hiçbir seansa kayıt olmayan üyeler (NOT EXISTS)
SELECT m.member_id, m.first_name, m.last_name
FROM member m
WHERE NOT EXISTS (
    SELECT 1
    FROM session_registration sr
    WHERE sr.member_id = m.member_id
);


-- D5: Aynı uzmanlık alanındaki antrenör çiftleri (RENAME / SELF-JOIN)
SELECT
    t1.first_name AS trainer_1,
    t2.first_name AS trainer_2,
    t1.specialization
FROM trainer AS t1
JOIN trainer AS t2
    ON t1.specialization = t2.specialization
   AND t1.trainer_id < t2.trainer_id;

-- D6: Bütün kategorilerde en az bir seansa katılan üyeler (DIVISION)
SELECT DISTINCT m.member_id, m.first_name, m.last_name
FROM member m
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT category
        FROM training_session
    ) AS all_categories
    WHERE NOT EXISTS (
        SELECT 1
        FROM session_registration sr
        JOIN training_session ts ON sr.session_id = ts.session_id
        WHERE sr.member_id = m.member_id
          AND ts.category = all_categories.category
    )
);