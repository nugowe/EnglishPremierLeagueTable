#!/usr/bin/R

# Loading the necessary R packages

#Rpackages=c("polite==0.1.3","rvest==1.0.4","kableExtra==1.4.0","gt==0.11.1","svglite==2.1.3","devtools","usethis==3.1.0")

#for (packages in Rpackages){install.packages(packages)} 

install.packages("remotes")

remotes::install_version("polite", version = "0.1.3")
remotes::install_version("rvest", version = "1.0.4")
remotes::install_version("kableExtra", version = "1.4.0")
remotes::install_version("gt", version = "0.11.1")
remotes::install_version("svglite", version = "2.1.3")
remotes::install_version("usethis", version = "3.1.0")


library(polite)
library(tidyverse)
library(rvest)
library(kableExtra)
library(gt)
library(svglite)
library(devtools)
library(usethis)




url <- "https://en.wikipedia.org/wiki/2024%E2%80%9325_Premier_League"


session = bow(user_agent = "EPL-Table-Scrape", url)

EPLTable <- scrape(session) %>% html_nodes("table.wikitable:nth-child(50)") %>% html_table()

EPLTable <- as.data.frame(EPLTable)

WebscrapeTime <- format(Sys.time(), "%A %B %Y, %H:%M:%S (CST)")

EPLTable <- as.data.frame(EPLTable)

EPLTable$Badge<- ""

EPLTable <- EPLTable[,c(1,12,2:11)]

names(EPLTable)[12] <- "Qualification/Regulation"

names(EPLTable)[11] <- "Pts"

EPLTable$Team <- unlist(strsplit(EPLTable$Team, " \\(.*\\)"))
EPLTable$Pts <- gsub("\\[d\\]|\\[c\\]", "", EPLTable$Pts)
Chelsealogo = "https://upload.wikimedia.org/wikipedia/en/c/cc/Chelsea_FC.svg"
Liverpoollogo = "https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg"
ManchesterCitylogo = "https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg"
ManchesterUnitedlogo = "https://upload.wikimedia.org/wikipedia/en/7/7a/Manchester_United_FC_crest.svg"
Evertonlogo = "https://upload.wikimedia.org/wikipedia/en/7/7c/Everton_FC_logo.svg"
Brightonlogo = "https://upload.wikimedia.org/wikipedia/en/f/fd/Brighton_%26_Hove_Albion_logo.svg"
Brentfordlogo ="https://upload.wikimedia.org/wikipedia/en/2/2a/Brentford_FC_crest.svg"
TottenhamHotspurlogo = "https://upload.wikimedia.org/wikipedia/en/b/b4/Tottenham_Hotspur.svg"
WestHamlogo = "https://upload.wikimedia.org/wikipedia/en/c/c2/West_Ham_United_FC_logo.svg"
AstonVillalogo = "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Aston_Villa_FC_new_crest.svg/250px-Aston_Villa_FC_new_crest.svg.png"
Arsenallogo = "https://upload.wikimedia.org/wikipedia/en/5/53/Arsenal_FC.svg"
WolverhamptonWandererslogo = "https://upload.wikimedia.org/wikipedia/en/f/fc/Wolverhampton_Wanderers.svg"
Burnleylogo = "https://upload.wikimedia.org/wikipedia/en/6/6d/Burnley_FC_Logo.svg"
CrystalPalacelogo = "https://upload.wikimedia.org/wikipedia/en/a/a2/Crystal_Palace_FC_logo_%282022%29.svg"
Fulhamlogo = "https://upload.wikimedia.org/wikipedia/en/e/eb/Fulham_FC_%28shield%29.svg"
#LutonTownlogo = "https://upload.wikimedia.org/wikipedia/en/9/9d/Luton_Town_logo.svg"
#SheffieldUnitedFClogo = "https://upload.wikimedia.org/wikipedia/en/9/9c/Sheffield_United_FC_logo.svg"
Bournemouthlogo = "https://upload.wikimedia.org/wikipedia/en/e/e5/AFC_Bournemouth_%282013%29.svg"
NewcastleUnitedlogo = "https://upload.wikimedia.org/wikipedia/en/5/56/Newcastle_United_Logo.svg"
Nottinghamforestlogo = "https://upload.wikimedia.org/wikipedia/en/e/e5/Nottingham_Forest_F.C._logo.svg"
IpswichTownlogo="https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Ipswich_Town.svg/250px-Ipswich_Town.svg.png"
Leicestercitylogo="https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/Leicester_City_crest.svg/250px-Leicester_City_crest.svg.png"
Southamptionlogo="https://upload.wikimedia.org/wikipedia/en/thumb/c/c9/FC_Southampton.svg/250px-FC_Southampton.svg.png"



logos <- c(Chelsealogo, Liverpoollogo, ManchesterCitylogo, ManchesterUnitedlogo, Evertonlogo, Brightonlogo, Brentfordlogo, TottenhamHotspurlogo, WestHamlogo, 
           
           AstonVillalogo, Arsenallogo, WolverhamptonWandererslogo, Leicestercitylogo, CrystalPalacelogo, Fulhamlogo, Southamptionlogo, IpswichTownlogo, Bournemouthlogo, NewcastleUnitedlogo, Nottinghamforestlogo)

logolist <- list()
for(k in 1:20){
  
  for(i in EPLTable$Team[k]){
    
    if(i == "Chelsea"){
      logolist <- append(logolist, Chelsealogo)
      
    }else if(i == "Liverpool"){
      
      logolist <- append(logolist, Liverpoollogo)
    }else if(i == "Manchester City"){
      
      logolist <- append(logolist, ManchesterCitylogo)
    }else if(i == "Manchester United"){
      
      logolist <- append(logolist, ManchesterUnitedlogo)
    }else if(i == "Everton"){
      
      logolist <- append(logolist, Evertonlogo)
    }else if(i == "Brighton & Hove Albion" ){
      
      logolist <- append(logolist, Brightonlogo)
    }else if(i == "Brentford"){
      
      logolist <- append(logolist, Brentfordlogo)
    }else if(i == "Tottenham Hotspur"  ){
      
      logolist <- append(logolist, TottenhamHotspurlogo)
    }else if(i == "West Ham United"   ){
      
      logolist <- append(logolist, WestHamlogo)
    }else if(i == "Aston Villa"    ){
      
      logolist <- append(logolist, AstonVillalogo)
    }else if(i == "Arsenal"  ){
      
      logolist <- append(logolist, Arsenallogo)
    }else if(i == "Wolverhampton Wanderers"){
      
      logolist <- append(logolist, WolverhamptonWandererslogo)
    }else if(i == "Leicester City" ){
      
      logolist <- append(logolist, Leicestercitylogo)
    }else if(i == "Crystal Palace"){
      
      logolist <- append(logolist, CrystalPalacelogo)
    }else if(i == "Fulham"){
      
      logolist <- append(logolist, Fulhamlogo)
    }else if(i == "Southampton" ){
      
      logolist <- append(logolist, Southamptionlogo)
    }else if(i == "Ipswich Town"  ){
      
      logolist <- append(logolist, IpswichTownlogo)
    }else if(i == "Bournemouth" ){
      
      logolist <- append(logolist, Bournemouthlogo)
    }else if(i == "Newcastle United"  ){
      
      logolist <- append(logolist, NewcastleUnitedlogo)
    }else if(i == "Nottingham Forest" ){
      
      logolist <- append(logolist, Nottinghamforestlogo)
    }
  }
}


#GT Tables

gt(EPLTable) %>%
  tab_header(
    
    title = html("<img src='https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg' style='height:70px;'>"),
    subtitle = html("<div style='background-color:#FCF6F5FF'>
    <img src='https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg' class='topstriker' style='height:100px;' 
    <div>
    <img src='https://resources.premierleague.com/premierleague/photos/players/250x250/p118748.png' class='topstrikerflag' style='height:100px;' 
    <br></br>
    <i style='font-family: Lato'; font-size:70px><strong>  TOP GOAL SCORER</strong></i>
    <i style='font-family: Lato'; font-size:70px> | <strong>MOHAMMED SALAH</strong> | <strong>29 GOALS</strong>
    <p style='font-family: Roboto; font-size: 20px; background-color: #B3C7D6FF; color:black; font-weight:bold; font-style:italic'>English Premier League | Table Standings for the 2023/2024 Season</p>
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
    colors = scales::col_numeric("#488A99", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "W",
    colors = scales::col_numeric("#1C4E80", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "D",
    colors = scales::col_numeric("#CD5C5C", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "L",
    colors = scales::col_numeric("#AC3E31", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "GF",
    colors = scales::col_numeric("#7E909A", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "GA",
    colors = scales::col_numeric("#A5D8DD", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  )  %>% data_color(
    
    columns = "GD",
    colors = scales::col_factor("#DBAE58", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Team",
    colors = scales::col_factor("#CED2CC", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Pos",
    colors = scales::col_factor("#CED2CC", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  )%>% data_color(
    
    columns = "Badge",
    colors = scales::col_factor("#CED2CC", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
    columns = "Pts"
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
  ) %>% gtsave(filename = "TableEPL.html")
