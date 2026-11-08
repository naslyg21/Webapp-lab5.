
-- Part 1: Create the database tables

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    student_email TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tutoring_requests (
    request_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course TEXT NOT NULL,
    topic TEXT NOT NULL,
    preferred_date TEXT NOT NULL,
    preferred_time TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'Open',
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


-- Part 2: Insert students and tutoring requests

INSERT OR IGNORE INTO students (student_id, student_name, student_email)
VALUES
    (1, 'Jordan Lee', 'jordan.lee@example.edu'),
    (2, 'Avery Patel', 'avery.patel@example.edu');

INSERT OR IGNORE INTO tutoring_requests
    (request_id, student_id, course, topic, preferred_date, preferred_time)
VALUES
    (1, 1, 'IS 6465', 'Forms', '2026-11-16', '14:00'),
    (2, 1, 'IS 6465', 'SQL SELECT', '2026-11-17', '15:00'),
    (3, 2, 'IS 6465', 'SQLite CRUD', '2026-11-18', '13:00');
-- Part 3: Query tutoring requests
SELECT * FROM students;

SELECT * FROM tutoring_requests;

SELECT * FROM tutoring_requests WHERE status = 'Open';

SELECT * FROM tutoring_requests WHERE request_id = 2;

SELECT
    tutoring_requests.request_id,
    students.student_name,
    students.student_email,
    tutoring_requests.course,
    tutoring_requests.topic,
    tutoring_requests.preferred_date,
    tutoring_requests.preferred_time,
    tutoring_requests.status
FROM tutoring_requests
JOIN students
ON tutoring_requests.student_id = students.student_id
ORDER BY tutoring_requests.preferred_date;

-- Part 4: Update one request

-- Update Jordan's tutoring topic
UPDATE tutoring_requests
SET topic = 'Advanced SQL Queries'
WHERE request_id = 2;

-- Cancel Avery's tutoring request
UPDATE tutoring_requests
SET status = 'Cancelled'
WHERE request_id = 3;

-- Part 5: Delete one test request

-- Insert a temporary test request
INSERT INTO tutoring_requests
(student_id, course, topic, preferred_date, preferred_time)
VALUES (1, 'IS 6465', 'Delete Practice', '2026-11-20', '10:00');

-- Delete only the test request
DELETE FROM tutoring_requests
WHERE request_id = 4;

-- Verify the remaining requests
SELECT * FROM tutoring_requests;