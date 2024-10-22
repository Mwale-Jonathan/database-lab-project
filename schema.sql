CREATE TABLE "BookCopy"(
    "id" bigserial NOT NULL,
    "book_id" BIGINT NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "location" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "BookCopy" ADD PRIMARY KEY("id");
CREATE TABLE "Author"(
    "id" bigserial NOT NULL,
    "full_name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Author" ADD PRIMARY KEY("id");
ALTER TABLE
    "Author" ADD CONSTRAINT "author_full_name_unique" UNIQUE("full_name");
CREATE TABLE "Student"(
    "id" bigserial NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" INTEGER NOT NULL,
    "student_number" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "Student" ADD PRIMARY KEY("id");
ALTER TABLE
    "Student" ADD CONSTRAINT "student_email_unique" UNIQUE("email");
ALTER TABLE
    "Student" ADD CONSTRAINT "student_phone_unique" UNIQUE("phone");
ALTER TABLE
    "Student" ADD CONSTRAINT "student_student_number_unique" UNIQUE("student_number");
CREATE TABLE "Book"(
    "id" bigserial NOT NULL,
    "isbn" VARCHAR(13) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "publisher_id" BIGINT NOT NULL,
    "publication_year" SMALLINT NOT NULL
);
ALTER TABLE
    "Book" ADD PRIMARY KEY("id");
ALTER TABLE
    "Book" ADD CONSTRAINT "book_title_unique" UNIQUE("title");
CREATE TABLE "Publisher"(
    "id" bigserial NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "country" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Publisher" ADD PRIMARY KEY("id");
ALTER TABLE
    "Publisher" ADD CONSTRAINT "publisher_name_unique" UNIQUE("name");
CREATE TABLE "Loan"(
    "id" bigserial NOT NULL,
    "book_copy_id" BIGINT NOT NULL,
    "student_id" BIGINT NOT NULL,
    "checkout_date" DATE NOT NULL,
    "due_date" DATE NOT NULL,
    "return_date" DATE NULL
);
ALTER TABLE
    "Loan" ADD PRIMARY KEY("id");
CREATE TABLE "BookAuthor"(
    "id" bigserial NOT NULL,
    "book_id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL
);
ALTER TABLE
    "BookAuthor" ADD PRIMARY KEY("id");
CREATE TABLE "Fine"(
    "id" bigserial NOT NULL,
    "loan_id" BIGINT NOT NULL,
    "student_id" BIGINT NOT NULL,
    "amount" INTEGER NOT NULL,
    "paid" BOOLEAN NOT NULL,
    "date_paid" TIMESTAMP(0) WITH
        TIME zone NULL
);
ALTER TABLE
    "Fine" ADD PRIMARY KEY("id");
ALTER TABLE
    "Book" ADD CONSTRAINT "book_publisher_id_foreign" FOREIGN KEY("publisher_id") REFERENCES "Publisher"("id");
ALTER TABLE
    "BookAuthor" ADD CONSTRAINT "bookauthor_author_id_foreign" FOREIGN KEY("author_id") REFERENCES "Author"("id");
ALTER TABLE
    "BookAuthor" ADD CONSTRAINT "bookauthor_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "Book"("id");
ALTER TABLE
    "Loan" ADD CONSTRAINT "loan_student_id_foreign" FOREIGN KEY("student_id") REFERENCES "Student"("id");
ALTER TABLE
    "Fine" ADD CONSTRAINT "fine_loan_id_foreign" FOREIGN KEY("loan_id") REFERENCES "Loan"("id");
ALTER TABLE
    "BookCopy" ADD CONSTRAINT "bookcopy_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "Book"("id");
ALTER TABLE
    "Fine" ADD CONSTRAINT "fine_student_id_foreign" FOREIGN KEY("student_id") REFERENCES "Student"("id");
ALTER TABLE
    "Loan" ADD CONSTRAINT "loan_book_copy_id_foreign" FOREIGN KEY("book_copy_id") REFERENCES "BookCopy"("id");
