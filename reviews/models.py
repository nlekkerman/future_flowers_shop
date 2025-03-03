from django.db import models
from django.contrib.auth.models import User


class Review(models.Model):
    """
    A model representing a review submitted by a user for a product or service.
    
    Attributes:
        user (ForeignKey): A reference to the User who submitted the review.
        rating (IntegerField): The rating given by the user, with options from 1 to 5.
        comment (TextField): The textual comment submitted by the user along with the rating.
        created_at (DateTimeField): The timestamp when the review was created.
        updated_at (DateTimeField): The timestamp when the review was last updated.
        status (CharField): The current status of the review (pending, approved, or rejected).
        last_modified (DateTimeField): The timestamp for when the review was last modified.
        deleted (BooleanField): A flag indicating if the review has been marked as deleted.

    Methods:
        __str__(): Returns a string representation of the review with the username of the reviewer.
        is_approved(): Returns a boolean indicating if the review's status is 'approved'.
    """
    STATUS_CHOICES = (
        ('pending', "Pending"),
        ('approved', "Approved"),
        ('rejected', "Rejected"),
    )

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.IntegerField(choices=[(i, i) for i in range(1, 6)])
    seed = models.ForeignKey('seeds.Seed', on_delete=models.CASCADE, related_name="reviews", null=True, blank=True )
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    def __str__(self):
        return f'Review by {self.user.username} on {self.seed.name if self.seed else 'No Seed'}'

    def is_approved(self):
        return self.status == 'approved'


class Comment(models.Model):
    """
    A model representing a comment on a review, submitted by a user.
    
    Attributes:
        review (ForeignKey): A reference to the Review this comment is associated with.
        user (ForeignKey): A reference to the User who submitted the comment.
        text (TextField): The content of the comment.
        created_at (DateTimeField): The timestamp when the comment was created.
        updated_at (DateTimeField): The timestamp when the comment was last updated.
        status (CharField): The current status of the comment (pending, approved, or rejected).
        last_modified (DateTimeField): The timestamp for when the comment was last modified.
        deleted (BooleanField): A flag indicating if the comment has been marked as deleted.

    Methods:
        __str__(): Returns a string representation of the comment with the username of the commenter and associated review.
    """
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
