TRUNCATE TABLE session_registration, training_session, member, trainer
RESTART IDENTITY CASCADE;
-- BÖLÜM D: SEED VERİLERİ
-- Her tabloya en az 5, en fazla 15 kayıt eklenir.

-- Üyeler
INSERT INTO member (first_name, last_name, join_date) VALUES
('Ali', 'Yilmaz', '2026-01-10'),
('Ayse', 'Kaya', '2026-01-15'),
('Mehmet', 'Demir', '2026-02-01'),
('Zeynep', 'Celik', '2026-02-10'),
('Can', 'Arslan', '2026-03-05'),
('Elif', 'Aydin', '2026-03-12'),
('Emre', 'Kurt', '2026-04-01');

-- Antrenörler
INSERT INTO trainer (first_name, last_name, specialization) VALUES
('Murat', 'Can', 'Fitness'),
('Selin', 'Oz', 'Fitness'),
('Burak', 'Tas', 'Cardio'),
('Deniz', 'Ak', 'Pilates'),
('Ece', 'Yildiz', 'Strength');

-- Antrenman seansları
INSERT INTO training_session
(session_date, start_time, end_time, capacity, status, category, trainer_id) VALUES
('2026-12-01', '09:00', '10:00', 10, 'scheduled', 'fitness', 1),
('2026-12-01', '11:00', '12:00', 12, 'scheduled', 'wellness', 2),
('2026-12-02', '09:00', '10:00', 8, 'completed', 'sports', 3),
('2026-12-02', '13:00', '14:00', 15, 'scheduled', 'fitness', 4),
('2026-12-03', '10:00', '11:00', 10, 'scheduled', 'sports', 5),
('2026-12-03', '14:00', '15:00', 12, 'completed', 'wellness', 1);

-- Üye-seans kayıtları
INSERT INTO session_registration (member_id, session_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 2),
(4, 4),
(5, 1),
(5, 5),
(6, 2);