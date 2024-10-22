-- =============================================
-- Library Management System - Complete CRUD Operations
-- =============================================

-- ---------------------
-- Publisher CRUD
-- ---------------------

-- Create Publishers
INSERT INTO "Publisher" (name, city, country)
VALUES 
    ('Penguin Random House', 'New York', 'USA'),
    ('HarperCollins', 'London', 'UK');

-- Read Publishers
SELECT * FROM "Publisher"; -- All publishers
SELECT * FROM "Publisher" WHERE id = 1; -- Specific publisher
SELECT * FROM "Publisher" WHERE country = 'USA'; -- Publishers by country

-- Update Publisher
UPDATE "Publisher"
SET 
    city = 'Los Angeles',
    country = 'USA'
WHERE id = 1;

-- Delete Publisher
DELETE FROM "Publisher" WHERE id = 1;

-- ---------------------
-- Author CRUD
-- ---------------------

-- Create Authors
INSERT INTO "Author" (full_name)
VALUES 
    ('Stephen King'),
    ('J.K. Rowling'),
    ('George R.R. Martin');

-- Read Authors
SELECT * FROM "Author"; -- All authors
SELECT * FROM "Author" WHERE id = 1; -- Specific author
SELECT * FROM "Author" WHERE full_name LIKE 'Stephen%'; -- Search by name pattern

-- Update Author
UPDATE "Author"
SET full_name = 'Stephen Edwin King'
WHERE id = 1;

-- Delete Author
DELETE FROM "Author" WHERE id = 1;

-- ---------------------
-- Book CRUD
-- ---------------------

-- Create Books
INSERT INTO "Book" (isbn, title, publisher_id, publication_year)
VALUES 
    ('9780747532743', 'Harry Potter and the Philosophers Stone', 1, 1997),
    ('9780439064873', 'Harry Potter and the Chamber of Secrets', 1, 1998);

-- Read Books
SELECT * FROM "Book"; -- All books

-- Read Books with Publisher Info
SELECT 
    b.*,
    p.name as publisher_name
FROM "Book" b
JOIN "Publisher" p ON b.publisher_id = p.id;

-- Search Books by Year
SELECT * FROM "Book" WHERE publication_year = 1997;

-- Update Book
UPDATE "Book"
SET 
    title = 'Harry Potter and the Philosopher''s Stone',
    publication_year = 1998
WHERE id = 1;

-- Delete Book
DELETE FROM "Book" WHERE id = 1;

-- ---------------------
-- BookCopy CRUD
-- ---------------------

-- Create Book Copies
INSERT INTO "BookCopy" (book_id, status, location)
VALUES 
    (1, 'Available', 'Main Library Floor 1'),
    (1, 'Available', 'Main Library Floor 2'),
    (2, 'In Repair', 'Maintenance');

-- Read Book Copies
SELECT * FROM "BookCopy"; -- All copies

-- Read Copies with Book Info
SELECT 
    bc.*,
    b.title,
    b.isbn
FROM "BookCopy" bc
JOIN "Book" b ON bc.book_id = b.id;

-- Read Available Copies
SELECT * FROM "BookCopy" WHERE status = 'Available';

-- Update Book Copy
UPDATE "BookCopy"
SET 
    status = 'Checked Out',
    location = 'On Loan'
WHERE id = 1;

-- Delete Book Copy
DELETE FROM "BookCopy" WHERE id = 1;

-- ---------------------
-- Student CRUD
-- ---------------------

-- Create Students
INSERT INTO "Student" (first_name, last_name, email, phone, student_number, timestamp)
VALUES 
    ('John', 'Doe', 'john.doe@university.com', 123456789, 1001, CURRENT_TIMESTAMP),
    ('Jane', 'Smith', 'jane.smith@university.com', 987654321, 1002, CURRENT_TIMESTAMP);

-- Read Students
SELECT * FROM "Student"; -- All students

-- Read Students with Active Loans
SELECT 
    s.*,
    COUNT(l.id) as active_loans
FROM "Student" s
LEFT JOIN "Loan" l ON s.id = l.student_id
WHERE l.return_date IS NULL
GROUP BY s.id;

-- Search Students
SELECT * FROM "Student" 
WHERE first_name LIKE 'J%' 
OR last_name LIKE 'S%';

-- Update Student
UPDATE "Student"
SET 
    email = 'john.doe.new@university.com',
    phone = 123456790
WHERE id = 1;

-- Delete Student
DELETE FROM "Student" WHERE id = 1;

-- ---------------------
-- Loan CRUD
-- ---------------------

-- Create Loans
INSERT INTO "Loan" (book_copy_id, student_id, checkout_date, due_date, return_date)
VALUES 
    (1, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', NULL),
    (2, 2, CURRENT_DATE - INTERVAL '7 days', CURRENT_DATE + INTERVAL '7 days', NULL);

-- Read Loans
SELECT * FROM "Loan"; -- All loans

-- Read Active Loans with Details
SELECT 
    l.*,
    s.first_name || ' ' || s.last_name as student_name,
    b.title as book_title,
    bc.status as book_status
FROM "Loan" l
JOIN "Student" s ON l.student_id = s.id
JOIN "BookCopy" bc ON l.book_copy_id = bc.id
JOIN "Book" b ON bc.book_id = b.id
WHERE l.return_date IS NULL;

-- Read Overdue Loans
SELECT * FROM "Loan"
WHERE return_date IS NULL
AND due_date < CURRENT_DATE;

-- Update Loan (Return Book)
UPDATE "Loan"
SET return_date = CURRENT_DATE
WHERE id = 1;

-- Delete Loan
DELETE FROM "Loan" WHERE id = 1;

-- ---------------------
-- BookAuthor CRUD
-- ---------------------

-- Create Book-Author Relationships
INSERT INTO "BookAuthor" (book_id, author_id)
VALUES 
    (1, 1),
    (1, 2),
    (2, 1);

-- Read Book-Author Relationships
SELECT * FROM "BookAuthor";

-- Read with Book and Author Info
SELECT 
    b.title,
    a.full_name as author_name
FROM "BookAuthor" ba
JOIN "Book" b ON ba.book_id = b.id
JOIN "Author" a ON ba.author_id = a.id;

-- Update Book-Author Relationship
UPDATE "BookAuthor"
SET author_id = 3
WHERE book_id = 1 AND author_id = 2;

-- Delete Book-Author Relationship
DELETE FROM "BookAuthor" 
WHERE book_id = 1 AND author_id = 1;

-- ---------------------
-- Fine CRUD
-- ---------------------

-- Create Fines
INSERT INTO "Fine" (loan_id, student_id, amount, paid, date_paid)
VALUES 
    (1, 1, 500, false, NULL),
    (2, 2, 1000, true, CURRENT_TIMESTAMP);

-- Read Fines
SELECT * FROM "Fine"; -- All fines

-- Read Unpaid Fines with Details
SELECT 
    f.*,
    s.first_name || ' ' || s.last_name as student_name,
    b.title as book_title
FROM "Fine" f
JOIN "Student" s ON f.student_id = s.id
JOIN "Loan" l ON f.loan_id = l.id
JOIN "BookCopy" bc ON l.book_copy_id = bc.id
JOIN "Book" b ON bc.book_id = b.id
WHERE f.paid = false;

-- Update Fine (Mark as Paid)
UPDATE "Fine"
SET 
    paid = true,
    date_paid = CURRENT_TIMESTAMP
WHERE id = 1;

-- Delete Fine
DELETE FROM "Fine" WHERE id = 1;

-- ---------------------
-- Complex Queries
-- ---------------------

-- Get Books with Multiple Copies Status
SELECT 
    b.title,
    COUNT(bc.id) as total_copies,
    SUM(CASE WHEN bc.status = 'Available' THEN 1 ELSE 0 END) as available_copies,
    SUM(CASE WHEN bc.status = 'Checked Out' THEN 1 ELSE 0 END) as checked_out_copies
FROM "Book" b
LEFT JOIN "BookCopy" bc ON b.id = bc.book_id
GROUP BY b.id, b.title;

-- Get Student Loan History with Fines
SELECT 
    s.first_name || ' ' || s.last_name as student_name,
    b.title as book_title,
    l.checkout_date,
    l.due_date,
    l.return_date,
    COALESCE(f.amount, 0) as fine_amount,
    f.paid as fine_paid
FROM "Student" s
LEFT JOIN "Loan" l ON s.id = l.student_id
LEFT JOIN "BookCopy" bc ON l.book_copy_id = bc.id
LEFT JOIN "Book" b ON bc.book_id = b.id
LEFT JOIN "Fine" f ON l.id = f.loan_id
ORDER BY l.checkout_date DESC;

-- Get Books with Multiple Authors
SELECT 
    b.title,
    STRING_AGG(a.full_name, ', ') as authors
FROM "Book" b
JOIN "BookAuthor" ba ON b.id = ba.book_id
JOIN "Author" a ON ba.author_id = a.id
GROUP BY b.id, b.title;

-- Get Most Popular Books (Most Borrowed)
SELECT 
    b.title,
    COUNT(l.id) as times_borrowed
FROM "Book" b
JOIN "BookCopy" bc ON b.id = bc.book_id
JOIN "Loan" l ON bc.id = l.book_copy_id
GROUP BY b.id, b.title
ORDER BY times_borrowed DESC;

-- Get Students with Overdue Books and Fines
SELECT 
    s.first_name || ' ' || s.last_name as student_name,
    b.title as book_title,
    l.due_date,
    CURRENT_DATE - l.due_date as days_overdue,
    COALESCE(f.amount, 0) as fine_amount
FROM "Student" s
JOIN "Loan" l ON s.id = l.student_id
JOIN "BookCopy" bc ON l.book_copy_id = bc.id
JOIN "Book" b ON bc.book_id = b.id
LEFT JOIN "Fine" f ON l.id = f.loan_id
WHERE l.return_date IS NULL
AND l.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;
