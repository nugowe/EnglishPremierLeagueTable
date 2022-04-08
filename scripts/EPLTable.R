#!/usr/bin/R



#Rpackages=c("polite","rvest","kableExtra","gt","svglite")

#for (i in Rpackages){install.packages(i)} 

library(polite)
library(tidyverse)
library(rvest)
library(kableExtra)
library(gt)
library(svglite)

#Running checks on Packages installed
#for (i in Rpackages){cran_check_results(i, flavours = cran_check_flavours(i), quiet = FALSE)}
#for (i in Rpackages){cran_check_flavours(i)}

url <- "https://en.wikipedia.org/wiki/2021%E2%80%9322_Premier_League"


session = bow(user_agent = "EPL-Table-Scrape", url)

EPLTable <- scrape(session) %>% html_nodes("table.wikitable:nth-child(29)") %>% html_table()

WebscrapeTime <- format(Sys.time(), "%A %B %Y, %H:%M:%S (CST)")

EPLTable <- as.data.frame(EPLTable)

EPLTable$Badge<- ""

EPLTable <- EPLTable[,c(1,12,2:11)]

names(EPLTable)[12] <- "Qualification/Regulation"

names(EPLTable)[11] <- "Pts"


Chelsealogo <- "https://upload.wikimedia.org/wikipedia/en/c/cc/Chelsea_FC.svg"
Liverpoollogo <- "https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg"
ManchesterCitylogo <- "https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg"
ManchesterUnitedlogo <- "https://upload.wikimedia.org/wikipedia/en/7/7a/Manchester_United_FC_crest.svg"
Evertonlogo <- "https://upload.wikimedia.org/wikipedia/en/7/7c/Everton_FC_logo.svg"
Brightonlogo <- "https://upload.wikimedia.org/wikipedia/en/f/fd/Brighton_%26_Hove_Albion_logo.svg"
Brentfordlogo <-"https://upload.wikimedia.org/wikipedia/en/2/2a/Brentford_FC_crest.svg"
TottenhamHotspurlogo <- "https://upload.wikimedia.org/wikipedia/en/b/b4/Tottenham_Hotspur.svg"
WestHamlogo <- "https://upload.wikimedia.org/wikipedia/en/c/c2/West_Ham_United_FC_logo.svg"
AstonVillalogo <- "https://upload.wikimedia.org/wikipedia/en/f/f9/Aston_Villa_FC_crest_%282016%29.svg"
Arsenallogo <- "https://upload.wikimedia.org/wikipedia/en/5/53/Arsenal_FC.svg"
WolverhamptonWandererslogo <- "https://upload.wikimedia.org/wikipedia/en/f/fc/Wolverhampton_Wanderers.svg"
LeicesterCitylogo <- "https://upload.wikimedia.org/wikipedia/en/2/2d/Leicester_City_crest.svg"
CrystalPalacelogo <- "https://upload.wikimedia.org/wikipedia/en/0/0c/Crystal_Palace_FC_logo.svg"
Watfordlogo <- "https://upload.wikimedia.org/wikipedia/en/e/e2/Watford.svg"
LeedsUnitedlogo <- "https://upload.wikimedia.org/wikipedia/en/5/54/Leeds_United_F.C._logo.svg"
Southamptonlogo <- "https://upload.wikimedia.org/wikipedia/en/c/c9/FC_Southampton.svg"
Burnleylogo <- "https://upload.wikimedia.org/wikipedia/en/6/62/Burnley_F.C._Logo.svg"
NewcastleUnitedlogo <- "https://upload.wikimedia.org/wikipedia/en/5/56/Newcastle_United_Logo.svg"
NorwichCitylogo <- "https://upload.wikimedia.org/wikipedia/en/8/8c/Norwich_City.svg"

logos <- c(Chelsealogo, Liverpoollogo, ManchesterCitylogo, ManchesterUnitedlogo, Evertonlogo, Brightonlogo, Brentfordlogo, TottenhamHotspurlogo, WestHamlogo, 
           
           AstonVillalogo, Arsenallogo, WolverhamptonWandererslogo, LeicesterCitylogo, CrystalPalacelogo, Watfordlogo, LeedsUnitedlogo, Southamptonlogo, Burnleylogo, NewcastleUnitedlogo, NorwichCitylogo)



logolist <- list()
for(k in 1:20){

for(i in EPLTable$Team[k]){
  
  if(i == "Chelsea"){
    logolist <- append(logolist, logos[1])
    
  }else if(i == "Liverpool (X)"){
    
    logolist <- append(logolist, logos[2])
  }else if(i == "Manchester City"){
    
    logolist <- append(logolist, logos[3])
  }else if(i == "Manchester United"){
    
    logolist <- append(logolist, logos[4])
  }else if(i == "Everton"   ){
    
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
  }else if(i == "Leicester City" ){
    
    logolist <- append(logolist, logos[13])
  }else if(i == "Crystal Palace"){
    
    logolist <- append(logolist, logos[14])
  }else if(i == "Watford"){
    
    logolist <- append(logolist, logos[15])
  }else if(i == "Leeds United" ){
    
    logolist <- append(logolist, logos[16])
  }else if(i == "Southampton"  ){
    
    logolist <- append(logolist, logos[17])
  }else if(i == "Burnley" ){
    
    logolist <- append(logolist, logos[18])
  }else if(i == "Newcastle United"  ){
    
    logolist <- append(logolist, logos[19])
  }else if(i == "Norwich City" ){
    
    logolist <- append(logolist, logos[20])
  }
}
}







gt(EPLTable) %>%
  tab_header(
    
    title = md("<img src='https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg' style='height:70px;'> "),
    subtitle = md("*League Table Standings for the **2021/2022** Season*")) %>% cols_align(
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
    
    columns = "Qualification/Regulation",
    colors = scales::col_factor("Reds", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
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
    colors = scales::col_numeric("#CED2CC", n = 2 , domain = NULL),
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
  ) %>% data_color(
    
    columns = "Pts",
    colors = scales::col_numeric("Greens", n = 2 , domain = NULL),
    alpha = NULL,
    apply_to = c("fill", "text"),
    autocolor_text = TRUE
  ) %>% data_color(
    
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
    source_note = md("*Source: Wikipedia*")
  )%>% tab_source_note(
    source_note = md(sprintf("Last successful Webscrape time was %s", WebscrapeTime ))
  ) %>% gtsave("EPLTable.png", path = '/opl/epl/EPLTable.png')




