library("rvest")
library(data.table)
library(stringr)
library(dplyr)
#install.packages("dtplyr")
library(dtplyr)

z=1
situations = c('5v5','5v5home','5v5road','5v5close_home', '5v5close_road', '5v5close','5v5tied','5v5tied_home','5v5tied_road',
               '5v5leading','5v5leading_home','5v5leading_road','5v5trailing','5v5trailing_home','5v5trailing_road',
               '5v5up1','5v5up2','5v5down1','5v5down2','4v4','threeonthree','5v5firstperiod','5v5secondperiod','5v5thirdperiod',
               'all','5v4','4v5','PP','SH')
#seasons= c('201617','201516','201415','201314','201213')
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
    a=situations[z]
    assign(paste0(a, x+1), population[[1]])
    # setnames(population[[1]], old= c("FO%","Games","FO per game","FW per game", "FW", "FO"),
    #           new =c(paste(a,"FO%"),paste(a,"Games"),paste(a,"FO per game"),
    #                  paste(a,"FW per game"), paste(a,"FW"), paste(a,"FO")))
    if(count==0){ 
      db = population[[1]] }
    else {
      db= rbind(db,population[[1]]) }
    print(count)
    print(x)
    print(a)
    x=x+1
    y=y+1
    count=count+1
    
  }
  z=z+1
  
}

summary(db)
# fours= rbind(`4v42014`,`4v42015`,`4v42016`,`4v42017`)
# rm(`4v42014`,`4v42015`,`4v42016`,`4v42017`)
# fourvfive= rbind(`4v52014`,`4v52015`,`4v52016`,`4v52017`)
# rm(`4v52014`,`4v52015`,`4v52016`,`4v52017`)
# fivevfour= rbind(`5v42014`,`5v42015`,`5v42016`,`5v42017`)
# rm(`5v42014`,`5v42015`,`5v42016`,`5v42017`)
# fivevfive= rbind(`5v52014`,`5v52015`,`5v52016`,`5v52017`)
# rm(`5v52014`,`5v52015`,`5v52016`,`5v52017`)
# fivevfive_close_home= rbind(`5v5close_home2014`,`5v5close_home2015`,`5v5close_home2016`,`5v5close_home2017`)
# rm(`5v5close_home2014`,`5v5close_home2015`,`5v5close_home2016`,`5v5close_home2017`)
# fivevfive_close_road= rbind(`5v5close_road2014`,`5v5close_road2015`,`5v5close_road2016`,`5v5close_road2017`)
# rm(`5v5close_road2014`,`5v5close_road2015`,`5v5close_road2016`,`5v5close_road2017`)
# fivevfive_close= rbind(`5v5close2014`,`5v5close2015`,`5v5close2016`,`5v5close2017`)
# rm(`5v5close2014`,`5v5close2015`,`5v5close2016`,`5v5close2017`)
# fivevfive_down1= rbind(`5v5down12014`,`5v5down12015`,`5v5down12016`,`5v5down12017`)
# rm(`5v5down12014`,`5v5down12015`,`5v5down12016`,`5v5down12017`)
# fivevfive_down2= rbind(`5v5down22014`,`5v5down22015`,`5v5down22016`,`5v5down22017`)
# rm(`5v5down22014`,`5v5down22015`,`5v5down22016`,`5v5down22017`)

