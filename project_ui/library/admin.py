from django.contrib import admin
from django.core.exceptions import ValidationError
from .models import Author, Book, BookCopy, Fine, Loan, Publisher, Student, BookAuthor
from unfold.admin import ModelAdmin
from unfold.contrib.filters.admin import TextFilter, FieldTextFilter
from .forms import LoanForm


# Register your models here.
class BookAuthorInline(admin.TabularInline):
    model = BookAuthor
    extra = 1
    min_num = 1
    validate_min = True


@admin.register(Book)
class BookAdminClass(ModelAdmin):
    inlines = [BookAuthorInline]
    list_display = ["title", "isbn", "total_copies", "available_copies"]
    search_fields = ["title", "publication_year", "publisher__name"]

    def save_related(self, request, form, formsets, change):
        super().save_related(request, form, formsets, change)
        if not form.instance.bookauthor_set.exists():
            raise ValidationError("At least one author is required.")


@admin.register(Author)
class AuthorAdminClass(ModelAdmin):
    list_display = ["full_name"]
    search_fields = ["full_name"]


@admin.register(Publisher)
class PublisherAdminClass(ModelAdmin):
    list_display = ["name", "city", "country"]
    search_fields = ["name", "city", "country"]


@admin.register(Student)
class StudentAdminClass(ModelAdmin):
    list_display = ["last_name", "first_name", "email", "phone"]
    search_fields = ["last_name", "first_name", "email", "phone"]


@admin.register(BookCopy)
class BookCopyAdminClass(ModelAdmin):
    list_display = ["book__isbn", "book__title", "status", "location"]
    search_fields = ["book__isbn", "book__title"]


@admin.register(Loan)
class LoanAdminClass(ModelAdmin):
    form = LoanForm
    list_display = [
        "student__last_name",
        "student__first_name",
        "checkout_date",
        "due_date",
        "return_date",
    ]
    search_fields = [
        "student__last_name",
        "student__first_name",
        "book_copy__book__title",
    ]


@admin.register(Fine)
class FineAdminClass(ModelAdmin):
    list_display = [
        "student__last_name",
        "student__first_name",
        "amount",
        "paid",
        "date_paid",
    ]
    search_fields = [
        "student__last_name",
        "student__first_name",
        "student__student_number",
        "student__email",
        "amount",
        "paid",
        "date_paid",
    ]
