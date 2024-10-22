from django.shortcuts import render
from django.core.paginator import Paginator
from django.conf import settings
from django.db.models import Q
from .models import Book


# Create your views here.
def index(request):
    if request.htmx:
        q = request.GET.get("q")
        page_number = request.GET.get("page", 1)
        if q != None:
            book_list = Book.objects.filter(title__icontains=q).all()
        else:
            book_list = Book.objects.all()

        paginator = Paginator(book_list, settings.PAGE_SIZE)
        page_obj = paginator.get_page(page_number)

        context = {"books": page_obj}
        return render(request, "library/books-list.html", context)
    return render(request, "library/index.html")
