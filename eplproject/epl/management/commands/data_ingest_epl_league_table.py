from datetime import datetime
import json
import csv
from django.conf import settings
from django.core.management.base import BaseCommand, CommandError


from epl.models import EPLLeagueTable

class Command(BaseCommand):
    help = 'Upload epl league table csv from JSON file'

    def handle(self, *args, **kwargs):
        # set the path to the datafile
        csv_file = settings.BASE_DIR / 'epl' / 'data' / 'epl_league_table.csv' 
        assert csv_file.exists()

        with open(csv_file, 'r') as file:
            reader = csv.DictReader(file)
            for row in reader:
                try:
                    EPLLeagueTable.objects.create(**row)
                except Exception as e:
                    raise CommandError(f'Error importing row: {row}, {e}')

        self.stdout.write(self.style.SUCCESS('Successfully imported data from CSV file'))


       