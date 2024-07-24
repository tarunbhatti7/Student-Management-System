from django.contrib import admin
from .models import Courses
from .models import Degree ,sessions

# Register your models here.

class AccountCourses(admin.ModelAdmin):
    list_display = ('course_name',)
    search_fields = ['course_name']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

class AccountDegree(admin.ModelAdmin):
    list_display = ('degree_name',)
    search_fields = ['degree_name']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

class AccountSession(admin.ModelAdmin):
    list_display = ('start_date','end_date')
    search_fields = ['start_date','end_date']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

admin.site.register(Courses , AccountCourses)
admin.site.register(Degree , AccountDegree)
admin.site.register(sessions , AccountSession)