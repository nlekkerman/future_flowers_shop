from django.shortcuts import render

def home(request):
    """
    This view function renders the 'home.html' template.

    Args:
        request: The HTTP request object provided by Django.

    Returns:
        HttpResponse: An HTTP response object containing the rendered 'home.html' template.
    """
    return render(request, 'home/home.html')
