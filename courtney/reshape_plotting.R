library(reshape2)
library(readr)
library(ggplot2)
library(dplyr)

## Read in the data
courtney <- read_csv("https://raw.githubusercontent.com/ryanburge/pls2003_sp17/master/courtney/courtney.csv")

## I know that you want to map this, which is great but I wanted to just show you how you could ggplot the changes over time. 
## This line just pulls out the relevant columns and puts them in a new dataframe called c1
c1 <- select(courtney, CountyName, `2010`, `2011`, `2012`, `2013`, `2014`, `2015`)

## Then this turns that into a long data instead of wide data, if you just compare c1 to m1 after you run this command you will get what I am talking about
## Make sure you load the reshape2 package, that has the melt command in it
m1 <- melt(c1, id.vars = c("CountyName"))

## I wanted to just plot one to make sure I'm on the right track. Using Bond County
bond <- m1 %>% filter(CountyName == "Bond")

## Then plotting. It works. 
ggplot(bond, aes(x=variable, y= value, label = CountyName, color = CountyName)) + geom_line(aes(group = CountyName), size=1) 

## This saves it with a nice quality. 
ggsave(file="bond.png", type = "cairo-png")

## Here's plotting all the counties. It's a mess because there are so many of them. You might want to filter them somehow or other. 
ggplot(m1, aes(x=variable, y= value, label = CountyName, color = CountyName)) + geom_line(aes(group = CountyName), size=1) +
  theme(legend.position="bottom")  + 
  theme(legend.title = element_blank())

## This saves it with a nice quality. 
ggsave(file="all_counties.png", type = "cairo-png")