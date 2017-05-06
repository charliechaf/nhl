
#install.packages("rvest")
library("rvest")
library(data.table)
library(stringr)
library(dplyr)

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

shorthanded = rbind(Xsh2014,Xsh2015,Xsh2016,Xsh2017)
powerplay = rbind(Xpp2014,Xpp2015,Xpp2016,Xpp2017)
fivevfive = rbind(X5v52014,X5v52015,X5v52016,X5v52017)

