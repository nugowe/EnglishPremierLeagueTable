from django.shortcuts import render
from django.shortcuts import render
import datetime
from django.http import HttpResponse
from epl.models import EPLLeagueTable, EPLTopScorers

def index(request):
    context = {'epl_league_table': EPLLeagueTable.objects.all(), 'goal_scorers': EPLTopScorers.objects.filter(id=1)}
    return render(request, 'index.html', context)

