from django import forms
from .models import Review, Comment

class ReviewForm(forms.ModelForm):
    """
    A form for submitting a review.
    
    Fields:
        comment (CharField): The text of the review that the user writes. It has a character limit of 500.
        
    Methods:
        clean_comment: Ensures the review comment is not empty.
    """
    comment = forms.CharField(
        max_length=500,
        widget=forms.Textarea(attrs={'rows': 4, 'placeholder': 'Write your review here...'}),
        label='Review',
        error_messages={
            'max_length': 'Your review cannot exceed 500 characters.'
        }
    )

    class Meta:
        model = Review
        fields = ['rating', 'comment'] 

    def clean_comment(self):
        comment = self.cleaned_data.get('comment')
        if not comment or not comment.strip():
            raise forms.ValidationError("Review comment cannot be empty.")
        return comment

class CommentForm(forms.ModelForm):
    """
    Validates the 'comment' field to ensure it is not empty or just whitespace.
        
    Returns:
        The cleaned comment text if valid.
        
    Raises:
        ValidationError: If the comment is empty or consists of only whitespace.
    """
    
    text = forms.CharField(widget=forms.Textarea(attrs={'rows': 4, 'placeholder': 'Write your comment here...'}), label='Comment')

    class Meta:
        model = Comment
        fields = ['text']

    def clean_text(self):
        text = self.cleaned_data.get('text')
        if not text.strip():
            raise forms.ValidationError("Comment cannot be empty.")
        return text



class EditReviewForm(forms.ModelForm):
    # Use integers directly for rating choices since the model expects integers
    RATINGS = [(i, i) for i in range(1, 6)]  # 1 to 5 as integer ratings

    # Use forms.ChoiceField with integer choices
    rating = forms.ChoiceField(choices=RATINGS, widget=forms.RadioSelect, label='Rating')
    comment = forms.CharField(widget=forms.Textarea(attrs={'rows': 4, 'placeholder': 'Edit your review here...'}), label='Review')

    class Meta:
        model = Review
        fields = ['rating', 'comment']
        widgets = {
            'rating': forms.RadioSelect,
            'comment': forms.Textarea(attrs={'rows': 4, 'placeholder': 'Edit your review here...'}),
        }
    
    def clean_rating(self):
        rating = self.cleaned_data.get('rating')
        # Convert rating to integer before validation
        try:
            rating = int(rating)
        except ValueError:
            raise forms.ValidationError("Invalid rating.")
        
        if rating not in dict(self.RATINGS).keys():
            raise forms.ValidationError("Invalid rating.")
        return rating

    def clean_comment(self):
        comment = self.cleaned_data.get('comment')
        if not comment.strip():
            raise forms.ValidationError("Review comment cannot be empty.")
        return comment