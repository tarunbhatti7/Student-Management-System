from django.db import models
from User_profile.models import Student
import datetime
# Create your models here.

STATUS_CHOICES = (
   ('A', 'Accepted'),
   ('D', 'Declined'),
   ('W', 'Waiting')
)

class student_leave(models.Model):
    leave_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='student leave id')
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    start_date= models.DateField(verbose_name='from' , null=False , default=datetime.date.today)
    end_date = models.DateField(verbose_name='to' , null=False, default=datetime.date.today)
    name = models.CharField(verbose_name='student name' , null=False , blank= False ,max_length=30) 
    reason = models.CharField(max_length=10000,null=False,blank=False,verbose_name='reason')

    status = models.CharField(choices=STATUS_CHOICES , default = 'W',verbose_name='status',help_text='choose',max_length=20)
