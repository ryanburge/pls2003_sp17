team <- read.csv("https://raw.githubusercontent.com/ryanburge/pls2003_sp17/master/teamstats.csv")
bball <- read.csv(url("https://raw.githubusercontent.com/ryanburge/pls2003_sp17/master/dplyr.csv"))

sal <- bball %>% group_by(team_id, year) %>% summarise(salary = mean(salary))

merge <- merge(team, sal, by=c("team_id", "year"))

write.csv(merge, "teamsalaries.csv")


bbcor <- select(merge, w, l, r, ab, h, double, triple, hr, bb, so, sb, cs, attendance, salary)

cor <- round(cor(bbcor), 1)

ggcorrplot(cor, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           method="circle", 
           colors = c("firebrick1", "white", "green3"), 
           title="Correlogram of Baseball Stats", 
           ggtheme=theme_bw)