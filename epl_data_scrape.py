import requests

from bs4 import BeautifulSoup

import pandas as pd
import re

BASE_URL = 'https://en.wikipedia.org/wiki/2024–25_Premier_League'

response = requests.get(BASE_URL)
soup = BeautifulSoup(response.content, 'html.parser')


table = soup.select_one('#League_table').parent.find_next_sibling('table')

rows = table.find_all('tr')[1:]

team_data = []


for row in rows:
  # team name is the only  element under the 
  team_name = row.find("th").text.strip()
  
  # goals-for col
  gf = row.find_all('td')[5].text

  pld = row.find_all('td')[1].text

  W = row.find_all('td')[2].text

  L = row.find_all('td')[3].text

  GA = row.find_all('td')[1].text



  # append each team's data to team_data list
  team_data.append({
      'CLUB_NAME': team_name,
      'CLUB_LOGO': "",
      'TOTAL_NUMBER_OF_GAMES_PLAYED': int(pld),
      'TOTAL_NUMBER_OF_WINS': int(W),
      'TOTAL_NUMBER_OF_LOSSES': int(L),
      'GOALS_FOR': int(gf),
      'GOALS_AGAINST': int(GA)

  })

  x = pd.DataFrame(team_data)

  x.to_csv("epl_league_table.csv", index=False)


table = soup.select_one('#Top_scorers').parent.find_next_sibling('table')
# Get all the table rows containing data (ie - not including the first row)
# The first row only contains table header information
rows = table.find_all('tr')[1:]

topscorers = []

# We can now iterate over each row, and grab the team name and goals-for data.
for row in rows:
  players = row.find_all('td')[1].text
  club = row.find_all('td')[-2].text
  goals = row.find_all('td')[-1].text
  
  topscorers.append({
    'PLAYER_NAME': players,
    'CLUB_NAME': club,
    'CLUB_LOGO': "",
    'TOTAL_NUMBER_GOALS': goals
  })

  df = pd.DataFrame(topscorers)
  
  df['PLAYER_NAME'] = df['PLAYER_NAME'].str.replace(r'\n', '', regex=True)
  df['CLUB_NAME'] = df['CLUB_NAME'].str.replace(r'\n', '', regex=True)
  df['CLUB_LOGO'] = df['CLUB_LOGO'].str.replace(r'\n', '', regex=True)
  df['TOTAL_NUMBER_GOALS'] = df['TOTAL_NUMBER_GOALS'].str.replace(r'\n', '', regex=True)
  
  df = df.head(3) 
  
  df.to_csv("/home/nosa2k/MYPROJECTS/EPLPROJECTS/EPLLeagueTable/EnglishPremierLeagueTable/eplproject/epl/data/epl_top_scorers.csv", index=False)
    
  
 
  
 
  