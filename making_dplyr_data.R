salary <- read.csv("baseball/salary.csv")
master <- read.csv("baseball/Master.csv")
master$player_id <- master$playerID

master <- select(master, player_id, nameFirst, nameLast, weight, height, bats, throws)
salary <- select(salary, player_id, year, team_id, league_id, salary)

master <- filter(master, year > 1985)
salary <- filter(salary, year > 1985)


hit <- read.csv("/baseball/batting.csv")

h1 <- hit %>% group_by(player_id, year)


total <- merge(m1, h1, by=c("player_id", "year", "team_id"))

total$league_id <- total$league_id.y

total$league_id.y <- NULL
total$league_id.x <- NULL

write.csv(total, "dplyr.csv")

