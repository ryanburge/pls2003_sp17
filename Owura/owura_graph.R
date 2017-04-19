library(reshape2)
library(ggplot2)

owura_personnel <- read_csv("D:/pls2003_sp17/owura_personnel.csv")
owura <- melt(owura_personnel, id.vars = c("Country Name"))
owura <- owura[-(1:24), , drop = FALSE]

ggplot(owura, aes(x=variable, y= value/1000, label = country, color = country, label = country)) + 
  geom_line(aes(group = country), size=1) +
  theme(legend.position="bottom") + 
  xlab("Year") + ylab("Personnel Spending (in Thousands)") + 
  theme(legend.title = element_blank())

