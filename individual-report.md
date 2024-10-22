# Individual Technical Report: University Library Management System
## UI Implementation and Django Configuration

### 1. Introduction

As a member of the development team for the University Library Management System, my primary responsibilities focused on implementing the user interface using Django, configuring multiple database support, and integrating the Django Unfold admin interface. This report details my individual contributions to the system's frontend architecture, database configuration, and project documentation.

### 2. Django Project Configuration

#### 2.1 Multiple Database Setup
I implemented Django's multiple database support to maintain separation between Django's internal tables and our library management tables. My configuration in settings.py:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    },
    'library_db': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': env('DB_NAME'),
        'USER': env('DB_USER'),
        'PASSWORD': env('DB_PASSWORD'),
        'HOST': env('DB_HOST'),
        'PORT': env('DB_PORT'),
    }
}

DATABASE_ROUTERS = ['library.router.LibraryRouter']
```

I created a custom database router to handle model routing:

```python
class LibraryRouter:
    """
    Router to manage library app database operations
    """
    def db_for_read(self, model, **hints):
        if model._meta.app_label == 'library':
            return 'library_db'
        return 'default'

    def db_for_write(self, model, **hints):
        if model._meta.app_label == 'library':
            return 'library_db'
        return 'default'
```

#### 2.2 Django Models Implementation
I created Django models to interface with our existing PostgreSQL tables:

```python
from django.db import models

class Student(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    phone = models.IntegerField(unique=True)
    student_number = models.IntegerField(unique=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'Student'
        managed = False

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
```

### 3. UI Implementation

#### 3.1 Django Unfold Integration
I implemented Django Unfold to create a modern, responsive admin interface. My customizations included:

```python
# admin.py
from django.contrib import admin
from unfold.admin import ModelAdmin
from .models import Student, Book, Loan

@admin.register(Student)
class StudentAdmin(ModelAdmin):
    list_display = ('student_number', 'first_name', 'last_name', 'email')
    search_fields = ('student_number', 'email', 'last_name')
    list_filter = ('timestamp',)
    
    fieldsets = (
        ('Personal Information', {
            'fields': ('first_name', 'last_name', 'email', 'phone')
        }),
        ('Student Details', {
            'fields': ('student_number',)
        }),
    )
```

#### 3.2 Custom Views and Templates
I developed custom views for specific library operations:

```python
# views.py
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Book, Loan
from .forms import LoanForm

class BookLoanView(LoginRequiredMixin, View):
    template_name = 'library/loan_book.html'
    
    def get(self, request, book_id):
        book = get_object_or_404(Book, id=book_id)
        form = LoanForm(initial={'book': book})
        return render(request, self.template_name, {'form': form, 'book': book})
    
    def post(self, request, book_id):
        form = LoanForm(request.POST)
        if form.is_valid():
            loan = form.save(commit=False)
            loan.due_date = timezone.now() + timedelta(days=14)
            loan.save()
            messages.success(request, 'Book successfully loaned.')
            return redirect('book_detail', book_id=book_id)
        return render(request, self.template_name, {'form': form})
```

I created corresponding templates using Tailwind CSS:

```html
<!-- templates/library/loan_book.html -->
{% extends 'base.html' %}

{% block content %}
<div class="max-w-2xl mx-auto p-4">
    <h1 class="text-2xl font-bold mb-4">Loan Book: {{ book.title }}</h1>
    
    <form method="post" class="space-y-4">
        {% csrf_token %}
        {{ form.as_p }}
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">
            Confirm Loan
        </button>
    </form>
</div>
{% endblock %}
```

### 4. Project Documentation

#### 4.1 Setup Documentation
I created comprehensive setup documentation covering:

1. Environment Configuration:
```bash
# .env setup
DEBUG=True
SECRET_KEY=your-secret-key
DB_NAME=library_db
DB_USER=library_user
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
```

2. Installation Steps:
```bash
# Virtual environment setup
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Database migrations
python manage.py makemigrations
python manage.py migrate
```

#### 4.2 PowerPoint Presentation
I created and presented slides covering:

1. System Architecture
   - Django MVT pattern
   - Multiple database configuration
   - Admin interface customization

2. UI Implementation
   - Django Unfold features
   - Custom views and forms
   - Responsive design

3. Live Demo
   - Student management
   - Book checkout process
   - Fine calculation system

### 5. Challenges and Solutions

During implementation, I encountered and resolved several challenges:

1. **Database Integration**:
   - Challenge: Connecting Django with existing PostgreSQL tables
   - Solution: Implemented unmanaged models and custom database router

2. **Admin Interface Customization**:
   - Challenge: Creating intuitive interfaces for library staff
   - Solution: Utilized Django Unfold's advanced features and custom ModelAdmin classes

3. **User Experience**:
   - Challenge: Streamlining complex library operations
   - Solution: Developed custom views with clear user flows and feedback

### 6. Conclusion

My individual contributions focused on creating a user-friendly, maintainable interface for the Library Management System. Key achievements include:

- Successfully implemented multiple database support
- Created an intuitive admin interface using Django Unfold
- Developed comprehensive documentation and presentation materials
- Implemented responsive UI with Tailwind CSS

The system has been well-received by library staff, with positive feedback on its ease of use and functionality. Through this project, I gained valuable experience in:

- Django framework configuration
- Database integration
- UI/UX design
- Technical documentation
- Project presentation

### 7. Future Recommendations

Based on my implementation experience, I recommend:

1. Implementing real-time notifications for overdue books
2. Adding a mobile-responsive checkout interface
3. Integrating barcode scanning functionality
4. Developing an API for future mobile app integration

