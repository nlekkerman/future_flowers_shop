from django.shortcuts import render, redirect, get_object_or_404
from .models import Human
from .forms import HumanForm
import json
import logging
from django.shortcuts import render
from django.http import JsonResponse

logger = logging.getLogger(__name__)

def api_humans(request):
    # Get last sync timestamp from query params
    last_sync = request.GET.get('last_sync', None)

    # Parse the timestamp
    if last_sync:
        last_sync = parse_datetime(last_sync)
        # Fetch only records modified after the last sync
        humans = Human.objects.filter(last_modified__gt=last_sync)
    else:
        humans = Human.objects.all()

    data = list(humans.values('id', 'first_name', 'last_name', 'age', 'email', 'last_modified'))
    return JsonResponse(data, safe=False)

    
def fetch_all_humans(request):
    humans = list(Human.objects.values())  # Convert QuerySet to a list of dictionaries
    return JsonResponse(humans, safe=False)

def human_list(request):
    # Fetch all humans from the Django database
    humans = Human.objects.all()
    
    # Convert the QuerySet to a list of dictionaries for easy comparison
    human_db_data = list(humans.values('id', 'first_name', 'last_name', 'age', 'email'))
    
    # Log the data from the Django database
    logger.info(f"Django DB Data: {json.dumps(human_db_data, indent=2)}")

    # Render the template with the database data and local storage data
    return render(request, 'human/human_list.html', {'humans': humans})

def human_detail(request, pk):
    human = get_object_or_404(Human, pk=pk)
    return render(request, 'human/human_detail.html', {'human': human})

def human_create(request):
    if request.method == 'POST':
        form = HumanForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('human/human_list')
    else:
        form = HumanForm()
    return render(request, 'human/human_form.html', {'form': form})

def human_update(request, pk):
    human = get_object_or_404(Human, pk=pk)
    if request.method == 'POST':
        form = HumanForm(request.POST, instance=human)
        if form.is_valid():
            form.save()
            return redirect('human_list')
    else:
        form = HumanForm(instance=human)
    return render(request, 'human/human_form.html', {'form': form})

def human_delete(request, pk):
    human = get_object_or_404(Human, pk=pk)
    if request.method == 'POST':
        human.delete()
        return redirect('human_list')
    return render(request, 'human/human_confirm_delete.html', {'human': human})
