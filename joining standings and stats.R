team = read.csv('team.csv')
rm(Season2014,Season2015,Season2016,Season2017,X5v52014,X5v52015,
   X5v52016,X5v52017,Xpp2014,Xpp2015,Xpp2016,Xpp2017,Xsh2014,Xsh2015,Xsh2016,Xsh2017)
left = left_join(standings,team, by=c("Team" = "unique_lookup"))
left = left_join(left,fivevfive, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))
left = left_join(left,powerplay, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))
left = left_join(left,shorthanded, by=c("unique.fivevfive.Team." = "Team", "year" = "year"))