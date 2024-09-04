from django.db import models
from django.utils import timezone

class Human(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    age = models.IntegerField()
    email = models.EmailField()
    last_modified = models.DateTimeField(auto_now=True)  # Automatically set to the current date/time on save
    deleted = models.BooleanField(default=False)  # Soft delete flag to indicate if a record is "deleted"

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

    def to_dict(self):
        return {
            'id': self.id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'age': self.age,
            'email': self.email,
            'last_modified': self.last_modified.isoformat(),  # Ensure the datetime is JSON serializable
            'deleted': self.deleted,
        }
