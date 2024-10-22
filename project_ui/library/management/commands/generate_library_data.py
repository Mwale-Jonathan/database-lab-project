# yourapp/management/commands/populate_book_data.py

from django.core.management.base import BaseCommand
from django.core.files.base import ContentFile
from django.utils.text import slugify
from library.models import Author, Publisher, Book, BookCopy
from faker import Faker
import random
from django.utils import timezone

fake = Faker()


class Command(BaseCommand):
    help = "Populate the database with mock book data"

    def add_arguments(self, parser):
        parser.add_argument("num_books", type=int, help="Number of books to generate")

    def handle(self, *args, **options):
        num_books = options["num_books"]

        self.stdout.write("Generating authors...")
        authors = self.generate_authors(50)

        self.stdout.write("Generating publishers...")
        publishers = self.generate_publishers(20)

        self.stdout.write(f"Generating {num_books} books and their copies...")
        self.generate_books_and_copies(num_books, authors, publishers)

        self.stdout.write(
            self.style.SUCCESS(
                f"Successfully populated the database with {num_books} books and related entities."
            )
        )

    def generate_authors(self, num_authors):
        authors = []
        for _ in range(num_authors):
            author = Author.objects.create(full_name=fake.name())
            authors.append(author)
        return authors

    def generate_publishers(self, num_publishers):
        publishers = []
        for _ in range(num_publishers):
            publisher = Publisher.objects.create(
                name=fake.company(), city=fake.city(), country=fake.country()
            )
            publishers.append(publisher)
        return publishers

    def generate_books_and_copies(self, num_books, authors, publishers):
        for i in range(num_books):
            book = Book.objects.create(
                isbn=fake.isbn10(),
                title=fake.catch_phrase(),
                publisher=random.choice(publishers),
                publication_year=random.randint(1950, 2023),
            )

            # Add authors
            book_authors = random.sample(authors, random.randint(1, 3))
            book.authors.set(book_authors)

            # Generate 1-5 copies for each book
            for _ in range(random.randint(1, 5)):
                BookCopy.objects.create(
                    book=book,
                    status=random.choice(["Available", "Loaned", "Lost"]),
                    location=fake.street_address(),
                )

            if (i + 1) % 10 == 0:
                self.stdout.write(f"Generated {i + 1} books...")
