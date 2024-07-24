from django.contrib import admin
from .models import feedback
# Register your models here.
class AccountFeedback(admin.ModelAdmin):
    list_display = ('title', 'student_id')
    search_fields = ['title']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

admin.site.register(feedback,AccountFeedback)