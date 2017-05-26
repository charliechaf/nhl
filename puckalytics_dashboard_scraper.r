library("rvest")
library(data.table)
library(stringr)
library(dplyr)
library(dtplyr)
library(beepr)

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
beep(sound=4)
