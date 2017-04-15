un <- read_csv("C:/Users/Ryan Burge/Desktop/un_votes.csv")
un <- un[,-1]
un$type <- as.factor(un$type)
un$type <- ordered(un$type, levels = c("Yes", "No", "Abstain", "Absent"))

ggplot(un, aes(x=year, y=count, label = type, fill = type)) + 
  geom_col(position = "dodge") + facet_grid(Country ~ .) +
theme(legend.position="bottom") + theme(legend.title = element_blank()) + 
  guides(col = guide_legend(reverse = TRUE)) + xlab("Year") + ylab("Number of Votes")

