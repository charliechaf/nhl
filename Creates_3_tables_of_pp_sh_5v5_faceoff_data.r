
#install.packages("rvest")
library("rvest")
library(data.table)
library(stringr)
library(dplyr)
x = 2013
z=1
situations = c('sh','pp','5v5','sh','pp','5v5','sh','pp','5v5','sh','pp','5v5')
for (i in 1:4){
  for(i in 1:3){
    url <- sprintf("http://puckbase.com/stats/team-faceoffs?situation=%s&sort=faceoff_pct&year=%s",situations[z] ,x)
    population <- url %>%
    read_html() %>%
    html_nodes(xpath='/html/body/div/div[3]/div[2]/table') %>%
    html_table(fill=TRUE)
    population[[1]]$year= x+1
    # setnames(population[[1]], old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
                        # sprintf(new =c("FO%","Games","FO per game",
                        # "FW per game", "FW", "FO"),situations[z]))
    
    assign(paste0("X",situations[z], x+1), population[[1]])
    z=z+1
  }
      x=x+1
}

setnames(X5v52014, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("5v5 FO%","5v5 Games","5v5 FO per game",
                "5v5 FW per game", "5v5 FW", "5v5 FO"))
setnames(X5v52015, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
                   new =c("5v5 FO%","5v5 Games","5v5 FO per game",
                        "5v5 FW per game", "5v5 FW", "5v5 FO"))


setnames(X5v52016, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("5v5 FO%","5v5 Games","5v5 FO per game",
                "5v5 FW per game", "5v5 FW", "5v5 FO"))
setnames(X5v52017, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("5v5 FO%","5v5 Games","5v5 FO per game",
                "5v5 FW per game", "5v5 FW", "5v5 FO"))

setnames(Xpp2014, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("pp FO%","pp Games","pp FO per game",
                "pp FW per game", "pp FW", "pp FO"))
setnames(Xpp2015, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("pp FO%","pp Games","pp FO per game",
                "pp FW per game", "pp FW", "pp FO"))

setnames(Xpp2016, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("pp FO%","pp Games","pp FO per game",
                "pp FW per game", "pp FW", "pp FO"))
setnames(Xpp2017, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("pp FO%","pp Games","pp FO per game",
                "pp FW per game", "pp FW", "pp FO"))
setnames(Xsh2014, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("sh FO%","sh Games","sh FO per game",
                "sh FW per game", "sh FW", "sh FO"))

setnames(Xsh2015, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("sh FO%","sh Games","sh FO per game",
                "sh FW per game", "sh FW", "sh FO"))
setnames(Xsh2016, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("sh FO%","sh Games","sh FO per game",
                "sh FW per game", "sh FW", "sh FO"))
setnames(Xsh2017, old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
         new =c("sh FO%","sh Games","sh FO per game",
                "sh FW per game", "sh FW", "sh FO"))



shorthanded = rbind(Xsh2014,Xsh2015,Xsh2016,Xsh2017)
powerplay = rbind(Xpp2014,Xpp2015,Xpp2016,Xpp2017)
fivevfive = rbind(X5v52014,X5v52015,X5v52016,X5v52017)

