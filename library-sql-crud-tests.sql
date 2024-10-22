-- Test Suite for Library Management System CRUD Operations

-- Start transaction for testing
START TRANSACTION;

-- =====================
-- Author CRUD Tests
-- =====================

-- Create Author Tests
INSERT INTO "Author" (full_name) VALUES ('Test Author 1');
INSERT INTO "Author" (full_name) VALUES ('Test Author 2');

-- Test duplicate author name (should fail)
INSERT INTO "Author" (full_name) VALUES ('Test Author 1');

-- Read Author Tests
SELECT * FROM "Author" WHERE full_name LIKE 'Test Author%';
SELECT * FROM "Author" WHERE id = LAST_INSERT_ID();

-- Update Author Tests
UPDATE "Author" SET full_name = 'Updated Test Author' WHERE full_name = 'Test Author 1';
SELECT * FROM "Author" WHERE full_name = 'Updated Test Author';

-- Delete Author Tests
DELETE FROM "Author" WHERE full_name = 'Test Author 2';
SELECT * FROM "Author" WHERE full_name = 'Test Author 2'; -- Should return empty set

-- =====================
-- Publisher CRUD Tests
-- =====================

-- Create Publisher Tests
INSERT INTO "Publisher" (name, city, country) VALUES
('Test Publisher 1', 'Test City 1', 'Test Country 1');
INSERT INTO "Publisher" (name, city, country) VALUES
('Test Publisher 2', 'Test City 2', 'Test Country 2');

-- Test duplicate publisher name (should fail)
INSERT INTO "Publisher" (name, city, country) VALUES
('Test Publisher 1', 'Different City', 'Different Country');

-- Read Publisher Tests
SELECT * FROM "Publisher" WHERE name LIKE 'Test Publisher%';
SELECT * FROM "Publisher" WHERE city = 'Test City 1';

-- Update Publisher Tests
UPDATE "Publisher"
SET city = 'Updated City', country = 'Updated Country'
WHERE name = 'Test Publisher 1';

SELECT * FROM "Publisher" WHERE name = 'Test Publisher 1';

-- Delete Publisher Tests
DELETE FROM "Publisher" WHERE name = 'Test Publisher 2';
SELECT * FROM "Publisher" WHERE name = 'Test Publisher 2'; -- Should return empty set

-- =====================
-- Book CRUD Tests
-- =====================

-- Create Book Tests
INSERT INTO "Book" (isbn, title, publisher_id, publication_year)
SELECT '1234567890123', 'Test Book 1', id, 2024
FROM "Publisher" WHERE name = 'Test Publisher 1';

INSERT INTO "Book" (isbn, title, publisher_id, publication_year)
SELECT '9876543210987', 'Test Book 2', id, 2024
FROM "Publisher" WHERE name = 'Test Publisher 1';

-- Test duplicate title (should fail)
INSERT INTO "Book" (isbn, title, publisher_id, publication_year)
SELECT '5555555555555', 'Test Book 1', id, 2024
FROM "Publisher" WHERE name = 'Test Publisher 1';

-- Read Book Tests
SELECT b.*, p.name as publisher_name
FROM "Book" b
JOIN "Publisher" p ON b.publisher_id = p.id
WHERE b.title LIKE 'Test Book%';

-- Update Book Tests
UPDATE "Book" SET publication_year = 2025 WHERE title = 'Test Book 1';
SELECT * FROM "Book" WHERE title = 'Test Book 1';

-- Delete Book Tests
DELETE FROM "Book" WHERE title = 'Test Book 2';
SELECT * FROM "Book" WHERE title = 'Test Book 2'; -- Should return empty set

-- =====================
-- BookAuthor CRUD Tests
-- =====================

-- Create BookAuthor Tests
INSERT INTO "BookAuthor" (book_id, author_id)
SELECT b.id, a.id
FROM "Book" b, Author a
WHERE b.title = 'Test Book 1' 
AND a.full_name = 'Updated Test Author';

-- Read BookAuthor Tests
SELECT b.title, a.full_name
FROM "Book" b
JOIN "BookAuthor" ba ON b.id = ba.book_id
JOIN "Author" a ON ba.author_id = a.id
WHERE b.title = 'Test Book 1';

-- Update BookAuthor Tests
UPDATE "BookAuthor" ba
SET author_id = (SELECT id FROM "Author" WHERE full_name = 'Test Author 2')
WHERE book_id = (SELECT id FROM "Book" WHERE title = 'Test Book 1');

-- Delete BookAuthor Tests
DELETE FROM "BookAuthor"
WHERE book_id = (SELECT id FROM "Book" WHERE title = 'Test Book 1');

-- =====================
-- BookCopy CRUD Tests
-- =====================

-- Create BookCopy Tests
INSERT INTO "BookCopy" (book_id, status, location)
SELECT id, 'Available', 'Test Location 1'
FROM "Book" WHERE title = 'Test Book 1';

INSERT INTO "BookCopy" (book_id, status, location)
SELECT id, 'Available', 'Test Location 2'
FROM "Book" WHERE title = 'Test Book 1';

-- Read BookCopy Tests
SELECT bc.*, b.title
FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id
WHERE bc.location LIKE 'Test Location%';

-- Update BookCopy Tests
UPDATE "BookCopy"
SET status = 'Loaned', location = 'Updated Location'
WHERE location = 'Test Location 1';

SELECT * FROM "BookCopy" WHERE location = 'Updated Location';

-- Delete BookCopy Tests
DELETE FROM "BookCopy" WHERE location = 'Test Location 2';
SELECT * FROM "BookCopy" WHERE location = 'Test Location 2'; -- Should return empty set

-- =====================
-- Student CRUD Tests
-- =====================

-- Create Student Tests
INSERT INTO "Student" (first_name, last_name, email, phone, student_number) VALUES
('Test', 'Student 1', 'test1@university.edu', 1234567890, 11111);

INSERT INTO "Student" (first_name, last_name, email, phone, student_number) VALUES
('Test', 'Student 2', 'test2@university.edu', 9876543210, 22222);

-- Test duplicate email (should fail)
INSERT INTO "Student" (first_name, last_name, email, phone, student_number) VALUES
('Test', 'Student 3', 'test1@university.edu', 5555555555, 33333);

-- Read Student Tests
SELECT * FROM "Student" WHERE last_name LIKE 'Student%';
SELECT * FROM "Student" WHERE student_number = 11111;

-- Update Student Tests
UPDATE "Student"
SET phone = 5555555555, email = 'updated1@university.edu'
WHERE student_number = 11111;

SELECT * FROM "Student" WHERE student_number = 11111;

-- Delete Student Tests
DELETE FROM "Student" WHERE student_number = 22222;
SELECT * FROM "Student" WHERE student_number = 22222; -- Should return empty set

-- =====================
-- Loan CRUD Tests
-- =====================

-- Create Loan Tests
INSERT INTO "Loan" (book_copy_id, student_id, checkout_date, due_date)
SELECT bc.id, s.id, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY)
FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id
CROSS JOIN "Student" s
WHERE b.title = 'Test Book 1'
AND s.student_number = 11111
AND bc.status = 'Available'
LIMIT 1;

-- Read Loan Tests
SELECT l.*, b.title, CONCAT(s.first_name, ' ', s.last_name) as student_name
FROM "Loan" l
JOIN "BookCopy" bc ON l.book_copy_id = bc.id
JOIN "Book" b ON bc.book_id = b.id
JOIN "Student" s ON l.student_id = s.id
WHERE s.student_number = 11111;

-- Update Loan Tests
UPDATE "Loan" l
JOIN "Student" s ON l.student_id = s.id
SET l.due_date = DATE_ADD(l.due_date, INTERVAL 7 DAY)
WHERE s.student_number = 11111;

-- Mark loan as returned
UPDATE "Loan" l
JOIN "Student" s ON l.student_id = s.id
SET l.return_date = CURRENT_DATE
WHERE s.student_number = 11111;

-- =====================
-- Fine CRUD Tests
-- =====================

-- Create Fine Tests
INSERT INTO "Fine" (loan_id, student_id, amount)
SELECT l.id, l.student_id, 50
FROM "Loan" l
JOIN "Student" s ON l.student_id = s.id
WHERE s.student_number = 11111;

-- Read Fine Tests
SELECT f.*, CONCAT(s.first_name, ' ', s.last_name) as student_name
FROM "Fine" f
JOIN "Student" s ON f.student_id = s.id
WHERE s.student_number = 11111;

-- Update Fine Tests
UPDATE "Fine" f
JOIN "Student" s ON f.student_id = s.id
SET f.paid = TRUE, f.date_paid = CURRENT_TIMESTAMP
WHERE s.student_number = 11111;

SELECT * FROM "Fine" f
JOIN "Student" s ON f.student_id = s.id
WHERE s.student_number = 11111;

-- Delete Fine Tests (typically fines should not be deleted but archived)
DELETE FROM "Fine"
WHERE id = LAST_INSERT_ID();

-- =====================
-- Complex Test Scenarios
-- =====================

-- Test Scenario 1: Complete Book Checkout Process
START TRANSACTION;

-- Add new book and copies
INSERT INTO "Book" (isbn, title, publisher_id, publication_year)
SELECT '1111222233334', 'Test Scenario Book', id, 2024
FROM "Publisher" WHERE name = 'Test Publisher 1';

INSERT INTO "BookCopy" (book_id, status, location)
SELECT id, 'Available', 'Test Scenario Location'
FROM "Book" WHERE title = 'Test Scenario Book';

-- Add new student
INSERT INTO "Student" (first_name, last_name, email, phone, student_number)
VALUES ('Scenario', 'Student', 'scenario@university.edu', 1234567890, 99999);

-- Create loan
INSERT INTO "Loan" (book_copy_id, student_id, checkout_date, due_date)
SELECT bc.id, s.id, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY)
FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id
CROSS JOIN "Student" s
WHERE b.title = 'Test Scenario Book'
AND s.student_number = 99999
AND bc.status = 'Available'
LIMIT 1;

-- Verify book copy status changed to 'Loaned'
SELECT status FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id
WHERE b.title = 'Test Scenario Book';

COMMIT;

-- Test Scenario 2: Book Return Process with Fine
START TRANSACTION;

-- Mark book as returned late
UPDATE "Loan" l
JOIN "Student" s ON l.student_id = s.id
SET l.return_date = DATE_ADD(l.due_date, INTERVAL 5 DAY)
WHERE s.student_number = 99999;

-- Verify fine was created (should be triggered)
SELECT * FROM "Fine" f
JOIN "Student" s ON f.student_id = s.id
WHERE s.student_number = 99999;

-- Verify book copy status returned to 'Available'
SELECT status FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id
WHERE b.title = 'Test Scenario Book';

COMMIT;

-- =====================
-- Cleanup Test Data
-- =====================
START TRANSACTION;

-- Delete test data in correct order to maintain referential integrity
DELETE FROM "Fine" WHERE student_id IN (SELECT id FROM "Student" WHERE last_name LIKE 'Student%' OR last_name = 'Scenario');
DELETE FROM "Loan" WHERE student_id IN (SELECT id FROM "Student" WHERE last_name LIKE 'Student%' OR last_name = 'Scenario');
DELETE FROM "BookCopy" WHERE book_id IN (SELECT id FROM Book WHERE title LIKE 'Test%');
DELETE FROM "BookAuthor" WHERE book_id IN (SELECT id FROM Book WHERE title LIKE 'Test%');
DELETE FROM "Book" WHERE title LIKE 'Test%';
DELETE FROM "Author" WHERE full_name LIKE 'Test%' OR full_name = 'Updated Test Author';
DELETE FROM "Student" WHERE last_name LIKE 'Student%' OR last_name = 'Scenario';
DELETE FROM "Publisher" WHERE name LIKE 'Test Publisher%';

COMMIT;

-- Verify cleanup
SELECT COUNT(*) FROM "Fine" WHERE student_id IN (SELECT id FROM "Student" WHERE last_name LIKE 'Student%');
SELECT COUNT(*) FROM "Loan" WHERE student_id IN (SELECT id FROM "Student" WHERE last_name LIKE 'Student%');
SELECT COUNT(*) FROM "BookCopy" WHERE book_id IN (SELECT id FROM "Book" WHERE title LIKE 'Test%');
SELECT COUNT(*) FROM "Book" WHERE title LIKE 'Test%';
SELECT COUNT(*) FROM "Author" WHERE full_name LIKE 'Test%';
SELECT COUNT(*) FROM "Student" WHERE last_name LIKE 'Student%';
SELECT COUNT(*) FROM "Publisher" WHERE name LIKE 'Test Publisher%';
