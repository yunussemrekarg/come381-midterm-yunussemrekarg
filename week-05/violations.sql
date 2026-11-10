-- BÖLÜM B: CONSTRAINT İHLAL TESTLERİ
-- Her test ilgili kısıtlamayı ihlal etmeyi amaçlar.

\set VERBOSITY verbose
\set ON_ERROR_STOP off

-- Test verileri hazırlanır.
TRUNCATE TABLE session_registration, training_session, member, trainer
RESTART IDENTITY CASCADE;

INSERT INTO member (first_name, last_name, join_date)
VALUES ('Ali', 'Yilmaz', '2026-01-10');

INSERT INTO trainer (first_name, last_name, specialization)
VALUES ('Ayse', 'Demir', 'Fitness');

INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES
('2026-11-10', '10:00', '11:00', 10, 'scheduled', 'sports', 1);

-- TEST 1: NOT NULL ihlali
INSERT INTO member (first_name, last_name, join_date)
VALUES (NULL, 'Kaya', '2026-01-10');

-- TEST 2: UNIQUE ihlali
INSERT INTO session_registration (member_id, session_id)
VALUES (1, 1), (1, 1);

-- TEST 3: CHECK kapasite ihlali
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-11', '10:00', '11:00', 0, 'scheduled', 'sports', 1);

-- TEST 4: CHECK status ihlali
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-11', '12:00', '13:00', 10, 'unknown', 'sports', 1);

-- TEST 5: CHECK category ihlali
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-11', '14:00', '15:00', 10, 'scheduled', 'unknown', 1);

-- TEST 6: İki sütunlu CHECK ihlali
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-11', '16:00', '15:00', 10, 'scheduled', 'sports', 1);
-- TEST 6B: UNIQUE seans programı ihlali
-- Aynı antrenör aynı gün ve saatte ikinci seansı veremez.
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-10', '10:00', '12:00', 10, 'scheduled', 'fitness', 1);

-- TEST 7: Olmayan üyeye kayıt (FK ihlali)
INSERT INTO session_registration (member_id, session_id)
VALUES (999, 1);
-- TEST 7B: Olmayan seansa kayıt (FK ihlali)
INSERT INTO session_registration (member_id, session_id)
VALUES (1, 999);

-- TEST 8: Çocuğu bulunan antrenörü silme (RESTRICT)
DELETE FROM trainer WHERE trainer_id = 1;

-- TEST 9: CHECK sütununa NULL gönderme
-- CHECK, NULL sonucunu ihlal olarak değerlendirmez.
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES ('2026-11-12', '10:00', '11:00', 10, 'scheduled', NULL, 1);

-- TEST 10: İki sınır testi
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id)
VALUES
('2026-11-13', '10:00', '11:00', 1, 'scheduled', 'sports', 1),
('2026-11-13', '12:00', '13:00', 100, 'completed', 'wellness', 1);