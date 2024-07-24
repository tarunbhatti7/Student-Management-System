from django.db import models
from django.contrib.auth.models import AbstractBaseUser , BaseUserManager ,PermissionsMixin
from acadamic.models import Degree
import datetime
# manager here 

class Profile_Manager(BaseUserManager):

    def create_user(self,email,username,password=None):
        if not email:
            raise ValueError('Email required')
        if not username:
            raise ValueError('Username required')
        
        user = self.model(
            email = self.normalize_email(email),
            username = username,
        )
        user.set_password(password)
        user.save(using = self.db)
        return user 

    def create_superuser(self,email,username,password):
        
        if not email:
            raise ValueError('Email required')
        if not username:
            raise ValueError('Username required')
        if not password:
            raise ValueError('Username required')

        user = self.create_user(
            email=self.normalize_email(email),
            username=username,
            password=password,
        )

        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.is_active = True

        user.save(using = self.db)
        return user

# models here.

class Profile(AbstractBaseUser , PermissionsMixin):

    id              = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='profile_id')
    name            = models.CharField(verbose_name = 'name' , max_length = 60 , null = True , default='USER')
    email           = models.EmailField(verbose_name = 'email' , unique = True , max_length = 60)

    last_login      = models.DateTimeField(verbose_name='last login' , default=datetime.datetime.now())
    username        = models.CharField(verbose_name = 'username' , unique = True , max_length = 30 )
    is_admin        = models.BooleanField(default=False)
    is_active       = models.BooleanField(default=True)
    is_staff        = models.BooleanField(default=False)
    is_superuser    = models.BooleanField(default=False)


    objects = Profile_Manager()

    USERNAME_FIELD ='email'
    REQUIRED_FIELDS =['username']

    def __str__(self):
        return self.username
    
    def has_perm(self , perm , obj =None):
        return self.is_admin
    
    def has_module_perms(self,app_label):
        return True
    
class Admin(Profile):
    is_admin = True
    def __str__(self):
        return self.name

class admin_phone(models.Model):
    admin_id = models.ForeignKey(Admin,on_delete=models.CASCADE,default=1)
    phone_number = models.CharField(max_length=10 , null= False , unique=False)


class Student(Profile):
    degree_id = models.ForeignKey(Degree,on_delete=models.CASCADE,verbose_name='Degree',null=True)
    def __str__(self):
        return self.username

class student_phone(models.Model):
    student_id = models.ForeignKey(Student , on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=10 , null= False , unique=False)
