-- Gym and Training Management System
-- PostgreSQL database schema

-- 1. Gym members
CREATE TABLE member (
    member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    join_date DATE
);

-- 2. Trainers
CREATE TABLE trainer (
    trainer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialization VARCHAR(100)
);

-- 3. Training sessions
CREATE TABLE training_session (
    session_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_date DATE,
    start_time TIME,
    trainer_id INTEGER,
    CONSTRAINT fk_training_session_trainer
        FOREIGN KEY (trainer_id)
        REFERENCES trainer(trainer_id)
        ON DELETE RESTRICT
);

-- 4. Member registrations for training sessions
CREATE TABLE session_registration (
    registration_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INTEGER,
    session_id INTEGER,
    CONSTRAINT fk_registration_member
        FOREIGN KEY (member_id)
        REFERENCES member(member_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_registration_session
        FOREIGN KEY (session_id)
        REFERENCES training_session(session_id)
        ON DELETE CASCADE
);