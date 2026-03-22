-- =============================================
-- MOCK EXAM - Add category & difficulty columns + Sample Data
-- Run this in SSMS on your database
-- =============================================

-- Step 1: Add new columns (skip if Hibernate already created them)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('MockExam') AND name = 'category')
BEGIN
    ALTER TABLE MockExam ADD category NVARCHAR(100) DEFAULT 'General';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('MockExam') AND name = 'difficulty')
BEGIN
    ALTER TABLE MockExam ADD difficulty NVARCHAR(30) DEFAULT 'Beginner';
END
GO

-- Step 2: Update existing exams (adjust exam_id to match your data)
-- UPDATE MockExam SET category = 'Java', difficulty = 'Beginner' WHERE exam_id = 1;
-- UPDATE MockExam SET category = 'OOP & Design Patterns', difficulty = 'Intermediate' WHERE exam_id = 2;
-- UPDATE MockExam SET category = 'SQL & Database', difficulty = 'Beginner' WHERE exam_id = 3;

-- Step 3: Delete old sample data if you want fresh start (OPTIONAL - CAREFUL!)
-- DELETE FROM MockQuestion;
-- DELETE FROM MockAttempt;
-- DELETE FROM MockExam;

-- Step 4: Insert sample exams with categories
-- ===================== TECHNICAL - JAVA =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Java Fundamentals Quiz', N'Test your basic Java knowledge: variables, data types, loops, conditionals, and methods.', 30, 20, 'Java', 'Beginner', GETDATE());

INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Java Collections & Streams', N'Deep dive into ArrayList, HashMap, TreeSet, Stream API, Optional, and functional interfaces.', 45, 50, 'Java', 'Intermediate', GETDATE());

INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Java Interview Simulator', N'50 real interview questions from top tech companies. Covers multithreading, JVM internals, and exception handling.', 60, 100, 'Java', 'Advanced', GETDATE());

-- ===================== TECHNICAL - SQL =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'SQL Basics Challenge', N'Practice SELECT, WHERE, ORDER BY, and basic JOIN queries.', 25, 15, 'SQL & Database', 'Beginner', GETDATE());

INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'SQL Advanced Queries', N'Subqueries, window functions, CTEs, GROUP BY with HAVING, and query optimization techniques.', 40, 45, 'SQL & Database', 'Intermediate', GETDATE());

-- ===================== TECHNICAL - WEB =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'HTML & CSS Quick Test', N'Basic web structure, CSS selectors, flexbox, grid layout, and responsive design.', 20, 10, 'Web Development', 'Beginner', GETDATE());

INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Full-Stack Developer Test', N'End-to-end knowledge: frontend, backend, REST API design, and deployment concepts.', 90, 120, 'Web Development', 'Advanced', GETDATE());

-- ===================== TECHNICAL - OOP =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'OOP Concepts 101', N'Core principles: encapsulation, inheritance, polymorphism, abstraction, and interfaces.', 20, 15, 'OOP & Design Patterns', 'Beginner', GETDATE());

INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Design Patterns Quiz', N'Singleton, Factory, Observer, Strategy, Builder — when and how to use them in real projects.', 35, 40, 'OOP & Design Patterns', 'Intermediate', GETDATE());

-- ===================== TECHNICAL - DSA =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'DSA Coding Challenge', N'Solve problems involving sorting algorithms, searching, recursion, trees, and graph traversal.', 60, 80, 'Data Structures', 'Advanced', GETDATE());

-- ===================== TECHNICAL - GIT =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Git & Version Control', N'Branching strategies, merge vs rebase, conflict resolution, pull requests, and best practices.', 25, 30, 'Git & DevOps', 'Intermediate', GETDATE());

-- ===================== CAREER - INTERVIEW =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Tech Interview Top 50', N'The most frequently asked technical interview questions across Java, SQL, OOP, and system design.', 60, 100, 'Interview Prep', 'Advanced', GETDATE());

-- ===================== CAREER - CERTIFICATION =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'OCA Java SE Practice Exam', N'Simulates the real Oracle Certified Associate exam format, timing, and difficulty level.', 120, 150, 'Certification Practice', 'Advanced', GETDATE());

-- ===================== CAREER - APTITUDE =====================
INSERT INTO MockExam (title, description, duration_minutes, cost_coins, category, difficulty, created_at) VALUES
(N'Company Aptitude Test', N'Logical reasoning, pattern recognition, quantitative analysis — common in big company hiring.', 45, 60, 'Aptitude Test', 'Intermediate', GETDATE());

-- =============================================
-- DONE! You should now have 15 sample exams.
-- Remember to also add MockQuestion rows for each exam!
-- =============================================

SELECT exam_id, title, category, difficulty, cost_coins, duration_minutes FROM MockExam ORDER BY category, difficulty;
