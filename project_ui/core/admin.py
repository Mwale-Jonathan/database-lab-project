from django.contrib import admin
from unfold.admin import ModelAdmin
from django.contrib.auth.models import Group
from .models import User

# Register your models here.
admin.site.unregister(Group)


@admin.register(User)
class UserAdminClass(ModelAdmin):
    list_display = ["last_name", "first_name", "username", "email", "is_superuser"]
    search_fields = ["last_name", "first_name", "username", "email"]
    fields = [
        "first_name",
        "last_name",
        "username",
        "email",
        "password",
        "is_active",
        "is_superuser",
    ]


admin.site.site_header = "UNZALibrary"

admin.site.site_title = "UNZA Library Management System"

admin.site.index_title = "Library Management System"
