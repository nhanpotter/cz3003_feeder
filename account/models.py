from django.db import models
from django.contrib.auth import User
# Create your models here.

class StudentUserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)