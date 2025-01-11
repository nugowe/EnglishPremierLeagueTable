from django.db import models

class EPLLeagueTable(models.Model):
    CLUB_NAME = models.CharField(max_length=250)
    CLUB_LOGO = models.CharField(max_length=250)
    TOTAL_NUMBER_OF_GAMES_PLAYED = models.CharField(max_length=250)
    TOTAL_NUMBER_OF_WINS = models.CharField(max_length=250)
    TOTAL_NUMBER_OF_LOSSES = models.CharField(max_length=250)
    GOALS_FOR = models.CharField(max_length=250)
    GOALS_AGAINST = models.CharField(max_length=250)



class EPLTopScorers(models.Model):
    PLAYER_NAME = models.CharField(max_length=250)
    CLUB_NAME = models.CharField(max_length=250)
    CLUB_LOGO = models.CharField(max_length=250)
    TOTAL_NUMBER_GOALS = models.CharField(max_length=250)

   