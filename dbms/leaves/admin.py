from django.contrib import admin
from .models import student_leave
# Register your models here.

class AccountLeaves(admin.ModelAdmin):
    list_display =('name', 'status','start_date','end_date')
    search_fields = ['name']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

admin.site.register(student_leave,AccountLeaves)    