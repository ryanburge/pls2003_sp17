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
## But this plot is so huge it won't even work right. 
ggsave(file="all_counties.png", width =120, height =120, type = "cairo-png")


## This plots arrests by PD district and by year

courtney <- read_csv("https://raw.githubusercontent.com/ryanburge/pls2003_sp17/master/courtney/courtney.csv")
c1 <- select(courtney, `2010`, `2011`, `2012`, `2013`, `2014`, `2015`, StatePD_District)
m1 <- melt(c1, id.vars = c("StatePD_District"))
plot <- m1 %>% group_by(StatePD_District, variable) %>% summarise(total = sum(value))
ggplot(plot, aes(x=variable, y= total, label = StatePD_District, color = StatePD_District)) + geom_line(aes(group = StatePD_District), size=1)



## Make the Districts Look Better
p1 <- plot %>% filter(StatePD_District != "3 & 4")

p1$district <- as.numeric(p1$StatePD_District)

ggplot(p1, aes(x=variable, y= total, label = district, color = factor(district))) + geom_line(aes(group = factor(district)), size=1) +
  theme(legend.position="bottom")  + 
  theme(legend.title = element_blank())


d1 <- courtney %>% filter(StatePD_District =="1")  %>% select(CountyName, `2010`, `2011`)





