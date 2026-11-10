
-- BÖLÜM A: CONSTRAINT'LER
-- Gym and Training Management System

-- Gerekli yeni sütunları ekliyoruz.
ALTER TABLE training_session
    ADD COLUMN IF NOT EXISTS end_time TIME,
    ADD COLUMN IF NOT EXISTS capacity INTEGER,
    ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'scheduled',
    ADD COLUMN IF NOT EXISTS category VARCHAR(20) DEFAULT 'sports';

-- Üyelerin ad, soyad ve kayıt tarihi boş bırakılamaz.
ALTER TABLE member
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN join_date SET NOT NULL;

-- Antrenörlerin kişisel bilgileri boş bırakılamaz.
ALTER TABLE trainer
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN specialization SET NOT NULL;

-- Antrenman seanslarının gerekli bilgileri boş bırakılamaz.
ALTER TABLE training_session
    ALTER COLUMN session_date SET NOT NULL,
    ALTER COLUMN start_time SET NOT NULL,
    ALTER COLUMN end_time SET NOT NULL,
    ALTER COLUMN capacity SET NOT NULL,
    ALTER COLUMN status SET NOT NULL,

    ALTER COLUMN trainer_id SET NOT NULL;

-- Kayıtlar mutlaka bir üyeye ve seansa bağlı olmalıdır.
ALTER TABLE session_registration
    ALTER COLUMN member_id SET NOT NULL,
    ALTER COLUMN session_id SET NOT NULL;

-- Bir üye aynı antrenman seansına iki kez kaydolamaz.
ALTER TABLE session_registration
    ADD CONSTRAINT uq_registration_member_session
    UNIQUE (member_id, session_id);

-- Bir antrenör aynı gün ve saatte iki seans veremez.
ALTER TABLE training_session
    ADD CONSTRAINT uq_training_session_schedule
    UNIQUE (trainer_id, session_date, start_time);

-- Antrenman kapasitesi sıfırdan büyük olmalıdır.
ALTER TABLE training_session
    ADD CONSTRAINT chk_training_session_capacity
    CHECK (capacity > 0);

-- Seans durumu yalnızca belirtilen değerlerden biri olabilir.
ALTER TABLE training_session
    ADD CONSTRAINT chk_training_session_status
    CHECK (status IN ('scheduled', 'completed', 'cancelled'));

-- Seans kategorisi yalnızca belirtilen değerlerden biri olabilir.
ALTER TABLE training_session
    ADD CONSTRAINT chk_training_session_category
    CHECK (category IN ('sports', 'fitness', 'wellness'));

-- Seansın bitiş saati başlangıç saatinden sonra olmalıdır.
ALTER TABLE training_session
    ADD CONSTRAINT chk_training_session_time_order
    CHECK (end_time > start_time);
