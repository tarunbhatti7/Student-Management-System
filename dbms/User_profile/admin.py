from django.contrib import admin 
from django.contrib.auth.admin import UserAdmin
from .models import Student,Admin,student_phone,Profile,admin_phone
# Register your models here.

class AccountAdmin(UserAdmin):
    list_display = ('id','name','email')
    search_fields = ('email' , 'username')
    readonly_fields = ['id']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()


class PhoneStudent(UserAdmin):
    list_display = ('student_id','phone_number',)
    search_fields = ('student_id',)
    filter_horizontal = ()
    list_filter=()
    fieldsets =()


admin.site.site_title = "Student management system"
admin.site.site_header = "student management system"
admin.site.index_title = "student management system"

# admin.site.register(Profile,AccountAdmin)
admin.site.register(Admin,AccountAdmin)
admin.site.register(Student,AccountAdmin)
admin.site.register(student_phone)
admin.site.register(admin_phone)