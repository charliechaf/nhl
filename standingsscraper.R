#install.packages("rvest")
library("rvest")
library(data.table)
library(stringr)
x = 2014
z = "test"
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