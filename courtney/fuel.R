library(janitor)
library(tidyverse)
library(prophet)
library(reshape2)

fuel <- read_csv("C://pls2003_sp17/courtney/fuel.csv") %>% clean_names()

fuel$ds <- as.Date(paste0(fuel$x1, "-1"),format="%y-%b-%d")


fuel$x1 <- NULL

fuel <- melt(fuel, id.vars = "ds")

fuel <- fuel %>% na.omit()


fuel <- fuel %>% mutate(value = as.numeric(value))

prophet <- fuel %>% group_by(ds) %>% summarise(y = sum(value))

m <- prophet(weekly.seasonality = TRUE)
m <- add_seasonality(m, name='monthly', period=30.5, fourier.order=5)

m <- fit.prophet(m, prophet)
forecast <- predict(m, future)
prophet_plot_components(m, forecast)


