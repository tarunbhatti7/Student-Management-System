from django.db import models
from User_profile.models import Student

# Create your models here.

class feedback(models.Model):
    feedback_id = models.BigAutoField(auto_created=True,primary_key=True,serialize=False,verbose_name='feedback id ')
    student_id = models.ForeignKey(Student,on_delete=models.CASCADE ,verbose_name='student id')
    title = models.CharField(max_length=20,verbose_name='title',null=False)
    content = models.CharField(max_length=2000 , null= False)
    date_submitted = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title
    

