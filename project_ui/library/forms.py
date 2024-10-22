from django.forms import ModelForm
from .models import Loan, BookCopy


class LoanForm(ModelForm):
    class Meta:
        model = Loan
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Filter book_copy choices to only show available ones
        self.fields["book_copy"].queryset = BookCopy.objects.filter(status="Available")

        # If editing existing loan, include the current book_copy even if not available
        if self.instance and self.instance.pk:
            current_copy = self.instance.book_copy
            # Add the specific book_copy to the queryset without using union
            self.fields["book_copy"].queryset = (
                BookCopy.objects.filter(pk=current_copy.pk)
                | self.fields["book_copy"].queryset
            )
