library(reshape2)
library(ggplot2)

owura_personnel <- read_csv("D://pls2003_sp17/Owura/owura_personnel.csv")
owura <- melt(owura_personnel, id.vars = c("Country Name"))
owura <- owura[-(1:24), , drop = FALSE]

owura$value <- as.numeric(owura$value)
owura$country <- owura$`Country Name`
owura$`Country Name` <- NULL



ggplot(owura, aes(x=variable, y= value/1000, label = country, color = country, label = country)) + 
  geom_line(aes(group = country), size=1) +
  theme(legend.position="bottom") + 
  xlab("Year") + ylab("Personnel Spending (in Thousands)") + 
  theme(legend.title = element_blank())

## THIS IS THE STUFF I DID ON 4/25

## Loading data
armed  <- read_csv("C:/Users/Ryan Burge/Downloads/armed forces personell as percentage of labour force.csv")

## This is making the data long instead of wide
## I don't need the: [-(1:24), , drop = FALSE] stuff because you got rid of the unnecessary columns in the cleaned up dataset!

armed <- melt(armed, id.vars = c("Country Name"))

## This is just renaming the country variable to something that is easier, then deleting the old variable. 

armed$country <- armed$`Country Name`
armed$`Country Name` <- NULL

## This is the plot 

ggplot(armed, aes(x=variable, y= value, label = country, color = country)) + 
  geom_line(aes(group = country), size=1) +
  theme(legend.position="bottom") + 
  xlab("Year") + ylab("Personnel Spending as a % of Labor Force") + 
  theme(legend.title = element_blank())
