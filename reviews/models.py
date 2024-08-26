# reviews/models.py
from django.db import models
from django.contrib.auth.models import User
from seeds.models import Seed 

class Review(models.Model):
    STATUS_CHOICES = (
        ('pending', "Pending"),
        ('approved', "Approved"),
        ('rejected', "Rejected"),
    )

    seed = models.ForeignKey(Seed, on_delete=models.CASCADE, related_name='reviews')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.IntegerField(choices=[(i, i) for i in range(1, 6)])  # 1-5 star ratings
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_approved = models.BooleanField(default=False)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f'Review for {self.seed.name} by {self.user.username}'

class Comment(models.Model):
    STATUS_CHOICES = (
        ('pending', "Pending"),
        ('approved', "Approved"),
        ('rejected', "Rejected"),
    )

    review = models.ForeignKey(Review, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f'Comment by {self.user.username} on {self.review}'
