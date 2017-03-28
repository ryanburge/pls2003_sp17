library(dplyr)
library(haven)
library(car)

living <- read_dta("D:/pls2003_sp17/living.dta")

living$weight <- living$V941
living$height <- living$V2610

living$male <- Recode(living$V1801, "1=1; else=0")
living$educ <- sqrt(living$V2038)

living$physical <- living$V2640

living$stamps <- Recode(living$V5720, "1=1; else=0")

living$white <- Recode(living$V2102, "1=1; else=0")
living$black <- Recode(living$V2102, "2=1; else=0")

df <- select(living, weight, height, male, educ, physical, stamps, white, black)

write.csv(df, "living.csv")