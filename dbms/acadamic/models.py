from django.db import models
import datetime

# Create your models here.

class Degree(models.Model):
    degree_id   =  models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='course id')
    degree_name = models.CharField(max_length=200,verbose_name='course name')
    
    def __str__(self):
        return self.degree_name

class Courses(models.Model):
    course_id = models.BigAutoField(auto_created=True,primary_key=True,serialize=False,verbose_name='subject id')
    course_name = models.CharField(max_length=200,null=False,verbose_name='subject name')
    degree_id = models.ForeignKey(Degree,on_delete=models.CASCADE)

    def __str__(self):
        return self.course_name

class sessions(models.Model):
    session_id =  models.BigAutoField(auto_created=True,primary_key=True,serialize=False,verbose_name='session id')
    degree_id  = models.ForeignKey(Degree,on_delete=models.CASCADE)
    start_date= models.DateField(verbose_name='from' , null=False , default=datetime.date.today)
    end_date = models.DateField(verbose_name='to' , null=False, default=datetime.date.today)
