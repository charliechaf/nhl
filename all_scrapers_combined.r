##needed packages
library(rvest)
library(data.table)
library(stringr)
library(dplyr)
library(dtplyr)
library(beepr)


##standings scraper for since 2014- put into data frame of standings
x = 2014
for (i in 2014:2022){
  url <- sprintf("http://www.shrpsports.com/nhl/stand/%sfinalcnf.htm", x)
  population <- url %>%
    read_html() %>%
    html_nodes(xpath='/html/body/center/table[1]') %>%
    html_table(fill=TRUE)
  population[[1]]$year= x
  assign(paste0("Season", x), population[[1]])
  x= x+1
}

standings = rbind(Season2014,Season2015, Season2016, Season2017) #how can we automate for standings seasons?
standings = standings[- grep("CONFERENCE", standings$X2),]
standings = standings[- grep("ROW", standings$X3),]
setnames(standings, old= c('X1','X2','X3','X4','X5','X6','X7','X8','X9','X10','X11'), 
         new = c('Team','Record','ROW','Pts','GF','GA','Home','Away','Div','Cnf','ICF'))
standings$wins= as.numeric(str_split_fixed(standings$Record,"-",3)[,1])
standings$losses= as.numeric(str_split_fixed(standings$Record,"-",3)[,2])
standings$overtime= as.numeric(str_split_fixed(standings$Record,"-",3)[,3])

## faceoff scraper- put into 3 data frames: fivevfive, powerplay, shorthanded
z=1
situations = c('sh','pp','5v5')
for (i in situations){
  x = 2013
  for(i in 1:4){
    url <- sprintf("http://puckbase.com/stats/team-faceoffs?situation=%s&sort=faceoff_pct&year=%s",situations[z] ,x)
    population <- url %>%
      read_html() %>%
      html_nodes(xpath='/html/body/div/div[3]/div[2]/table') %>%
      html_table(fill=TRUE)
    population[[1]]$year= x+1
    population[[1]][1] = NULL
    a=situations[z]
    assign(paste0("X",situations[z], x+1), population[[1]])
    setnames(population[[1]], old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
             new =c(paste(a,"FO%"),paste(a,"Games"),paste(a,"FO per game"),
                    paste(a,"FW per game"), paste(a,"FW"), paste(a,"FO")))
    x=x+1
  }
  z=z+1    
}

fo_shorthanded = rbind(Xsh2014,Xsh2015,Xsh2016,Xsh2017)
fo_powerplay = rbind(Xpp2014,Xpp2015,Xpp2016,Xpp2017)
fo_fivevfive = rbind(X5v52014,X5v52015,X5v52016,X5v52017)

##making a team lookup table- put into data frame called: team
unique.fivevfive.Team = c("St. Louis Blues",	"Boston Bruins",	"Carolina Hurricanes",	"Detroit Red Wings",
                           "Anaheim Ducks",	"Dallas Stars",	"Chicago Blackhawks",	"San Jose Sharks",	"Arizona Coyotes",
                           "Montreal Canadiens",	"Washington Capitals",	"Los Angeles Kings",	"Philadelphia Flyers",
                           "Colorado Avalanche",	"New York Islanders",	"Toronto Maple Leafs",	"Minnesota Wild",	"Tampa Bay Lightning",
                           "Columbus Blue Jackets",	"Ottawa Senators",	"Winnipeg Jets",	"Nashville Predators",	"Pittsburgh Penguins",
                           "Edmonton Oilers",	"Florida Panthers",	"Calgary Flames",	"Vancouver Canucks",	"New Jersey Devils",	"New York Rangers",
                           "Buffalo Sabres")
city = c("St. Louis",	"Boston",	"Carolina",	"Detroit",
         "Anaheim",	"Dallas",	"Chicago",	"San Jose",	
         "Arizona",	"Montreal",	"Washington",	"Los Angeles",
         "Philadelphia",	"Colorado",	"New York",	"Toronto",
         "Minnesota",	"Tampa Bay",	"Columbus",	"Ottawa",	"Winnipeg",
         "Nashville",	"Pittsburgh",	"Edmonton",	"Florida",	"Calgary",
         "Vancouver",	"New Jersey",	"New York",	"Buffalo")
Team = c("Blues",	"Bruins ",	"Hurricanes ",	"Red Wings",	"Ducks ",
         "Stars ",	"Blackhawks ",	"Sharks",	"Coyotes ",	"Canadiens ",
         "Capitals ",	"Kings",	"Flyers ",	"Avalanche ",	"Islanders",
         "Maple Leafs",	"Wild ",	"Lightning",	"Blue Jackets",	"Senators ",
         "Jets ",	"Predators ",	"Penguins ",	"Oilers ",	"Panthers ",	"Flames ",
         "Canucks ",	"Devils",	"Rangers",	"Sabres ")
unique_lookup = c("St Louis",	"Boston",	"Carolina",	"Detroit",	"Anaheim",
                  "Dallas",	"Chicago",	"San Jose",	"Arizona",	"Montreal",
                  "Washington",	"Los Angeles",	"Philadelphia",	"Colorado",
                  "NY Islanders",	"Toronto",	"Minnesota",	"Tampa Bay",	"Columbus",
                  "Ottawa",	"Winnipeg",	"Nashville",	"Pittsburgh",	"Edmonton",	"Florida",
                  "Calgary",	"Vancouver",	"New Jersey",	"NY Rangers",	"Buffalo")


team = data_frame(unique.fivevfive.Team,city,Team,unique_lookup)
team$puck_team = if_else(condition = team$unique_lookup=="St Louis", "St. Louis", team$unique_lookup)

##removing unnecessary table and joining tables into a final table called: combined
rm(Season2014,Season2015,Season2016,Season2017,X5v52014,X5v52015,
   X5v52016,X5v52017,Xpp2014,Xpp2015,Xpp2016,Xpp2017,Xsh2014,Xsh2015,Xsh2016,Xsh2017) ##what does this do?
combined = left_join(standings,team, by=c("Team" = "unique_lookup"))
combined = left_join(combined,fo_fivevfive, by=c("unique.fivevfive.Team" = "Team", "year" = "year"))
combined = left_join(combined,fo_powerplay, by=c("unique.fivevfive.Team" = "Team", "year" = "year"))
combined = left_join(combined,fo_shorthanded, by=c("unique.fivevfive.Team" = "Team", "year" = "year"))

rm(fo_fivevfive, fo_powerplay, fo_shorthanded, standings)

##stats.hockeyanalysis.com scraper


z=1
situations = c('5v5','5v5home','5v5road','5v5close_home', '5v5close_road', '5v5close','5v5tied','5v5tied_home','5v5tied_road',
               '5v5leading','5v5leading_home','5v5leading_road','5v5trailing','5v5trailing_home','5v5trailing_road',
               '5v5up1','5v5up2','5v5down1','5v5down2','4v4','threeonthree','5v5firstperiod','5v5secondperiod','5v5thirdperiod',
               'all','5v4','4v5','PP','SH')
count=0
for (i in situations){
  x = 2013
  y=14
  for(i in 1:4){
    url <- sprintf("http://stats.hockeyanalysis.com/teamstats.php?db=%s%s&sit=%s&disp=1&sortdir=DESC&sort=GFPCT",x,y, situations[z])
    population <- url %>%
      read_html() %>%
      html_nodes(xpath='/html/body/table') %>%
      html_table(fill=TRUE)
    population[[1]]$year= x+1
    population[[1]]$situation= situations[z]
    population[[1]][1] = NULL
    if(count==0){ 
      db = population[[1]] }
    else {
      db= rbind(db,population[[1]]) }
    print(count)
    print(x)
    print(situations[z])
    x=x+1
    y=y+1
    count=count+1
  }
  z=z+1
}

library(tidyr)
pucka_wide= db %>% 
  gather("var", "val", -Team, -year, -situation) %>% 
  unite(key, situation, var) %>% 
  spread(key, val)
# db$TOI_mins = as.numeric(str_split_fixed(db$TOI, pattern = ":", 2)[,1]) + as.numeric(str_split_fixed(db$TOI, pattern = ":", 2)[,2])/60
# db$situation = as.factor(db$situation)
str(combined)
str(db)
str(pucka_wide)
combined= left_join(combined, pucka_wide, by=c("puck_team"= "Team", "year"="year"))

beep(sound=3)