from django.db import models


class Author(models.Model):
    id = models.BigAutoField(primary_key=True)
    full_name = models.CharField(unique=True, max_length=255)

    def __str__(self):
        return self.full_name

    class Meta:
        ordering = ["full_name"]
        managed = True
        db_table = "Author"


class Book(models.Model):
    id = models.BigAutoField(primary_key=True)
    isbn = models.CharField(max_length=13)
    title = models.CharField(unique=True, max_length=255)
    publisher = models.ForeignKey("Publisher", models.CASCADE)
    publication_year = models.SmallIntegerField()
    authors = models.ManyToManyField("Author", through="BookAuthor", blank=False)

    def __str__(self):
        return self.title

    class Meta:
        ordering = ["title"]
        managed = True
        db_table = "Book"

    def clean(self):
        super().clean()
        # This check will only work for existing books
        if self.pk and not self.authors.exists():
            raise ValidationError("At least one author is required.")

    @property
    def is_available(self):
        copies = BookCopy.objects.filter(book=self.id, status="Available").count()
        if copies > 0:
            return True
        return False

    @property
    def available_copies(self):
        copies = BookCopy.objects.filter(book=self.id, status="Available").count()
        return copies

    @property
    def total_copies(self):
        copies = BookCopy.objects.filter(book=self.id).count()
        return copies


class BookAuthor(models.Model):
    id = models.BigAutoField(primary_key=True)
    book = models.ForeignKey(Book, models.CASCADE)
    author = models.ForeignKey(Author, models.CASCADE)

    class Meta:
        managed = True
        db_table = "BookAuthor"


class BookCopy(models.Model):
    STATUS = (
        ("Available", "Available"),
        ("Loaned", "Loaned"),
        ("Lost", "Lost"),
    )
    id = models.BigAutoField(primary_key=True)
    book = models.ForeignKey(Book, models.CASCADE)
    status = models.CharField(max_length=50, choices=STATUS, default="Available")
    location = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.book.title} | BookCopy ID: {self.id}, Status: {self.status}"

    class Meta:
        ordering = [
            "book__title",
        ]
        managed = True
        db_table = "BookCopy"
        verbose_name_plural = "Book Copies"


class Fine(models.Model):
    id = models.BigAutoField(primary_key=True)
    loan = models.ForeignKey("Loan", models.CASCADE)
    student = models.ForeignKey("Student", models.CASCADE)
    amount = models.IntegerField(verbose_name="Amount (ZMW)")
    paid = models.BooleanField(default=False)
    date_paid = models.DateTimeField(auto_now=True, blank=True, null=True)

    def __str__(self):
        return f"Fine ID: {self.id}, Student ID: {self.student}, Amount: {self.amount}, Paid: {self.paid}"

    class Meta:
        managed = True
        db_table = "Fine"


class Loan(models.Model):
    id = models.BigAutoField(primary_key=True)
    book_copy = models.ForeignKey(BookCopy, models.CASCADE)
    student = models.ForeignKey("Student", models.CASCADE)
    checkout_date = models.DateField(auto_now_add=True)
    due_date = models.DateField()
    return_date = models.DateField(null=True, blank=True)

    def __str__(self):
        return f"Book Loaned by {self.student}"

    def save(self, *args, **kwargs):
        book_copy = BookCopy.objects.get(id=self.book_copy.id)
        if self.return_date:
            book_copy.status = "Available"
            book_copy.save()
        else:
            print("Book Loaned")
            book_copy.status = "Loaned"
            book_copy.save()
        return super().save(**kwargs)

    class Meta:
        ordering = ["-due_date"]
        managed = True
        db_table = "Loan"
        unique_together = ["book_copy", "checkout_date", "student"]

    def overdue_days(self):
        """Calculates the number of overdue days if the book was returned late."""
        if self.return_date and self.due_date:
            # If the return date is after the due date
            if self.return_date > self.due_date:
                # Calculate the difference in days
                delta = self.return_date - self.due_date
                return delta.days
            else:
                return 0  # No overdue days if returned on or before the due date
        elif not self.return_date and self.due_date:
            # If the book is not yet returned and today is past the due date
            if date.today() > self.due_date:
                delta = date.today() - self.due_date
                return delta.days
        return 0  # Return 0 if no return date or not overdue


class Publisher(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(unique=True, max_length=255)
    city = models.CharField(max_length=255)
    country = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.name}, {self.city}, {self.country}"

    class Meta:
        managed = True
        db_table = "Publisher"


class Student(models.Model):
    id = models.BigAutoField(primary_key=True)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.CharField(unique=True, max_length=255)
    phone = models.IntegerField()
    student_number = models.PositiveIntegerField(unique=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.last_name} {self.first_name}"

    class Meta:
        ordering = ["-student_number"]
        managed = True
        db_table = "Student"
