unique.fivevfive.Team. = c("St. Louis Blues",	"Boston Bruins",	"Carolina Hurricanes",	"Detroit Red Wings",
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

team = data_frame(unique.fivevfive.Team.,city,Team,unique_lookup)

rm(Season2014,Season2015,Season2016,Season2017,X5v52014,X5v52015,
   X5v52016,X5v52017,Xpp2014,Xpp2015,Xpp2016,Xpp2017,Xsh2014,Xsh2015,Xsh2016,Xsh2017)
left = left_join(standings,team, by=c("Team" = "unique_lookup"))
left = left_join(left,fivevfive, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))
left = left_join(left,powerplay, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))
left = left_join(left,shorthanded, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))
