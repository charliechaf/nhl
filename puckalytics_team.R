library("rvest")
library(data.table)
library(stringr)
library(dplyr)
#install.packages("dtplyr")
library(dtplyr)

z=1
situations = c('5v5','5v5close')
#seasons= c('201617','201516','201415','201314','201213')
for (i in situations){
  x = 2013
  y=14
  for(i in 1:2){
    url <- sprintf("https://puckalytics.com/#/teams?season=%s%s&situation=%s&Team=",x,y, situations[z])
    population <- url %>%
      read_html() %>%
      html_nodes(xpath='/html/body/div/div[2]/div/div/div/span[2]/span[2]/table') %>%
      html_table(fill=TRUE)
    # population[[1]]$year= x+1
    # population[[1]][1] = NULL
    a=situations[z]
    #assign(paste0("X",situations[z], x+1), population[[1]])
    # setnames(population[[1]], old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
    #          new =c(paste(a,"FO%"),paste(a,"Games"),paste(a,"FO per game"),
    #                 paste(a,"FW per game"), paste(a,"FW"), paste(a,"FO")))
    x=x+1
    y=y+1
  }
  z=z+1    
}