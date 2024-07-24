from django.contrib import admin
from .models import Notices
# Register your models here.

class AccountNotice(admin.ModelAdmin):
    list_display = ('notice_id','title','date_posted')
    search_fields = ['title']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()


admin.site.register(Notices,AccountNotice)    