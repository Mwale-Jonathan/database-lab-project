from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.timezone import now
from .models import Loan, Fine


@receiver(post_save, sender=Loan)
def loan_saved_handler(sender, instance, created, **kwargs):
    """
    Signal triggered when a Loan is saved.
    - `created` is True if a new object was created, False if updated.
    """

    # If the loan has a return date, check if it is overdue.
    if instance.return_date and instance.due_date:
        if instance.return_date > instance.due_date:
            fine, created = Fine.objects.get_or_create(
                loan=instance,
                student=instance.student,
                amount=(10 * instance.overdue_days()),
            )
