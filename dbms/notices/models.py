from django.db import models
import datetime

# Create your models here.
class Notices(models.Model):
    notice_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='notice id')
    title = models.CharField(max_length=20,null=False,verbose_name='title')
    content = models.CharField(max_length=3000,null=False,verbose_name='content')
    date_posted = models.DateTimeField(auto_now=True)
    image = models.ImageField(upload_to='notice_files',max_length=100000,verbose_name='notice files',blank=True,null=True)


