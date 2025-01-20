#!/usr/bin/R

# Loading the necessary R packages

Rpackages=c("polite","rvest","kableExtra","gt","svglite")

for (packages in Rpackages){install.packages(packages)} 

library(polite)
library(tidyverse)
library(rvest)
library(kableExtra)
library(gt)
library(svglite)



url <- "https://en.wikipedia.org/wiki/2024%E2%80%9325_Premier_League"


session = bow(user_agent = "EPL-Table-Scrape", url)

EPLTable <- scrape(session) %>% html_nodes("table.wikitable:nth-child(41)") %>% html_table()

EPLTable <- as.data.frame(EPLTable)

WebscrapeTime <- format(Sys.time(), "%A %B %Y, %H:%M:%S (CST)")

EPLTable <- as.data.frame(EPLTable)

EPLTable$Badge<- ""

EPLTable <- EPLTable[,c(1,12,2:11)]

names(EPLTable)[12] <- "Qualification/Regulation"

names(EPLTable)[11] <- "Pts"

EPLTable$Team <- unlist(strsplit(EPLTable$Team, " \\(.*\\)"))

Chelsealogo = "https://upload.wikimedia.org/wikipedia/en/c/cc/Chelsea_FC.svg"
Liverpoollogo = "https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg"
ManchesterCitylogo = "https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg"
ManchesterUnitedlogo = "https://upload.wikimedia.org/wikipedia/en/7/7a/Manchester_United_FC_crest.svg"
Evertonlogo = "https://upload.wikimedia.org/wikipedia/en/7/7c/Everton_FC_logo.svg"
Brightonlogo = "https://upload.wikimedia.org/wikipedia/en/f/fd/Brighton_%26_Hove_Albion_logo.svg"
Brentfordlogo ="https://upload.wikimedia.org/wikipedia/en/2/2a/Brentford_FC_crest.svg"
TottenhamHotspurlogo = "https://upload.wikimedia.org/wikipedia/en/b/b4/Tottenham_Hotspur.svg"
WestHamlogo = "https://upload.wikimedia.org/wikipedia/en/c/c2/West_Ham_United_FC_logo.svg"
AstonVillalogo = "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Aston_Villa_FC_new_crest.svg/177px-Aston_Villa_FC_new_crest.svg.png"
Arsenallogo = "https://upload.wikimedia.org/wikipedia/en/5/53/Arsenal_FC.svg"
WolverhamptonWandererslogo = "https://upload.wikimedia.org/wikipedia/en/f/fc/Wolverhampton_Wanderers.svg"
Southamptonlogo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c9/FC_Southampton.svg/210px-FC_Southampton.svg.png"
CrystalPalacelogo = "https://upload.wikimedia.org/wikipedia/en/a/a2/Crystal_Palace_FC_logo_%282022%29.svg"
Fulhamlogo = "https://upload.wikimedia.org/wikipedia/en/e/eb/Fulham_FC_%28shield%29.svg"
LeicesterCitylogo = "https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/Leicester_City_crest.svg/240px-Leicester_City_crest.svg.png"
IpswichTownlogo = "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Ipswich_Town.svg/192px-Ipswich_Town.svg.png"
Bournemouthlogo = "https://upload.wikimedia.org/wikipedia/en/e/e5/AFC_Bournemouth_%282013%29.svg"
NewcastleUnitedlogo = "https://upload.wikimedia.org/wikipedia/en/5/56/Newcastle_United_Logo.svg"
Nottinghamforestlogo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/Nottingham_Forest_F.C._logo.svg/113px-Nottingham_Forest_F.C._logo.svg.png"


logos <- c(Chelsealogo, Liverpoollogo, ManchesterCitylogo, ManchesterUnitedlogo, Evertonlogo, Brightonlogo, Brentfordlogo, TottenhamHotspurlogo, WestHamlogo, 
           
           AstonVillalogo, Arsenallogo, WolverhamptonWandererslogo, Southamptonlogo, CrystalPalacelogo, Fulhamlogo, LeicesterCitylogo, IpswichTownlogo, Bournemouthlogo, NewcastleUnitedlogo, Nottinghamforestlogo)

logolist <- list()
for(k in 1:20){
  
  for(i in EPLTable$Team[k]){
    
    if(i == "Chelsea"){
      logolist <- append(logolist, logos[1])
      
    }else if(i == "Liverpool"){
      
      logolist <- append(logolist, logos[2])
    }else if(i == "Manchester City"){
      
      logolist <- append(logolist, logos[3])
    }else if(i == "Manchester United"){
      
      logolist <- append(logolist, logos[4])
    }else if(i == "Everton"){
      
      logolist <- append(logolist, logos[5])
    }else if(i == "Brighton & Hove Albion" ){
      
      logolist <- append(logolist, logos[6])
    }else if(i == "Brentford"){
      
      logolist <- append(logolist, logos[7])
    }else if(i == "Tottenham Hotspur"  ){
      
      logolist <- append(logolist, logos[8])
    }else if(i == "West Ham United"   ){
      
      logolist <- append(logolist, logos[9])
    }else if(i == "Aston Villa"    ){
      
      logolist <- append(logolist, logos[10])
    }else if(i == "Arsenal"  ){
      
      logolist <- append(logolist, logos[11])
    }else if(i == "Wolverhampton Wanderers"){
      
      logolist <- append(logolist, logos[12])
    }else if(i == "Southampton" ){
      
      logolist <- append(logolist, logos[13])
    }else if(i == "Crystal Palace"){
      
      logolist <- append(logolist, logos[14])
    }else if(i == "Fulham"){
      
      logolist <- append(logolist, logos[15])
    }else if(i == "Leicester City" ){
      
      logolist <- append(logolist, logos[16])
    }else if(i == "Ipswich Town"  ){
      
      logolist <- append(logolist, logos[17])
    }else if(i == "Bournemouth" ){
      
      logolist <- append(logolist, logos[18])
    }else if(i == "Newcastle United"  ){
      
      logolist <- append(logolist, logos[19])
    }else if(i == "Nottingham Forest" ){
      
      logolist <- append(logolist, logos[20])
    }
  }
}




gt(EPLTable) %>%
  tab_header(
    
    title = html("<img src='https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg' style='height:70px;'>"),
    subtitle = html("<div style='background-color:#FCF6F5FF'>
    <img src='https://resources.premierleague.com/premierleague/photos/players/250x250/p118748.png' class='topstriker' style='height:100px;' 
    <div>
    <img src='https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/Liverpool_FC.svg/176px-Liverpool_FC.svg.png' class='topstrikerflag' style='height:100px;' 
    <br></br>
    <i style='font-family: Lato'; font-size:70px><strong>  TOP GOAL SCORER</strong></i>
    <i style='font-family: Lato'; font-size:70px> | <strong>MOHAMMED SALAH</strong> | <strong>18 GOALS</strong>
    <p style='font-family: Roboto; font-size: 20px; background-color: #B3C7D6FF; color:black; font-weight:bold; font-style:italic'>English Premier League | Table Standings for the 2024/2025 Season</p>
    </div>
                    
                  </div>"))%>% cols_align(
                    align = "center",
                    columns = 1
                  ) %>% cols_align(
                    align = "left",
                    columns = 2
                  ) %>% cols_align(
                    align = "center",
                    columns = 3
                  ) %>% cols_align(
                    align = "right",
                    columns = 4
                  ) %>% cols_align(
                    align = "right",
                    columns = 5
                  ) %>% cols_align(
                    align = "right",
                    columns = 7
                  ) %>% cols_align(
                    align = "right",
                    columns = 8
                  ) %>% cols_align(
                    align = "right",
                    columns = 9
                  ) %>% cols_align(
                    align = "center",
                    columns = 10
                  ) %>% cols_align(
                    align = "center",
                    columns = 11
                  )  %>%
  tab_options(table.font.size = px(11)) %>%  opt_table_font(
    font = list(
      google_font(name = "Roboto Condensed")
    )
  ) %>% data_color(
    palette = "Reds",
    columns = "Qualification/Regulation"
  )%>%  data_color(
    
    columns = "Pld",
    colors = "#488A99",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "W",
    colors = "#1C4E80",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "D",
    colors = "#CD5C5C",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "L",
    colors = "#AC3E31",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "GF",
    colors = "#7E909A",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "GA",
    colors = "#A5D8DD",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Pts",
    colors = "Greens",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "GD",
    colors = "#DBAE58", 
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Team",
    colors = "#CED2CC",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Pos",
    colors = "#CED2CC",
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  )%>% data_color(
    
    columns = "Badge",
    colors = "#CED2CC", 
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% 
  text_transform(
    locations = cells_body(c(Badge)),
    fn = function(x) {
      web_image(url = logolist) 
    }
  ) %>% tab_options(table.font.size = px(12)) %>%
  opt_table_font(
    font = list(
      google_font(name = "Roboto Condensed")
      
    )
  ) %>% tab_options(column_labels.font.size = 11.5, column_labels.font.weight = "bold", data_row.padding = px(5)) %>% tab_source_note(
    source_note = md("*Source: Wikipedia & The English Premier League (Official Website)*")
  )%>% tab_source_note(
    source_note = md(sprintf("Last successful Webscrape time was %s", WebscrapeTime ))
  )  %>% opt_css(
    css = "
      .topstrikerflags {
      border-radius: 80%
    }
    "
  ) %>% gtsave(filename = "EPLTable.html")