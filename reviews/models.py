from django.db import models
from django.contrib.auth.models import User

class Review(models.Model):
    STATUS_CHOICES = (
        ('pending', "Pending"),
        ('approved', "Approved"),
        ('rejected', "Rejected"),
    )

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.IntegerField(choices=[(i, i) for i in range(1, 6)])  # 1-5 star ratings
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    def __str__(self):
        return f'Review by {self.user.username}'

    def is_approved(self):
        return self.status == 'approved'


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
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    def __str__(self):
        return f'Comment by {self.user.username} on review {self.review.id}'
