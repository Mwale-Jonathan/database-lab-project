from django.apps import AppConfig


class LibraryConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "library"
    ignore_models = [
        "Author",
        "Book",
        "BookAuthor",
        "BookCopy",
        "Fine",
        "Loan",
        "Publisher",
        "Student",
    ]

    def ready(self):
        import library.signals
