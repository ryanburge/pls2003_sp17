library(ggmap)
library(leaflet)
library(dplyr)
library(rvest)
library(xml2)



geo <- data.frame("location" =c("One World Trade NYC", "Willis Tower", "Mar-a-Lago", "Corn Palace", "Eastern Illinois University", "Apple Headquarters", "Area 51", "Big Sur", "Rodeo Drive", "Mile High Statdium"), count = c(11,2,13,55,21,6,23,98,10,4), stringsAsFactors = FALSE)


url <- "https://en.wikipedia.org/wiki/List_of_rallies_for_the_Donald_Trump_presidential_campaign,_2016"
trump <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[2]') %>%
  html_table()
trump <- trump[[1]]

trump$location <- as.character(trump$Venue)
geotrump <- geocode(trump$location)

mapdf <- cbind(trump, geotrump)
mapdf <- na.omit(mapdf)

pop<-paste0("<b>City</b>: ",mapdf$location, "<br>",
            "<b>Crowd Size</b>: ",mapdf$crowd)

mapdf <- select(mapdf, `Date of Rally`, City, State, Venue, location, lon, lat, crowd)

pop<-paste0("<b>Location</b>: ",eiu$location, "<br>",
            "<b>Counselor</b>: ",eiu$counselor, "<br>",
            "<b>Date</b>: ",  eiu$date_ )


leaflet()%>%
  addProviderTiles(providers$Stamen.Toner)%>%
  addCircleMarkers(lng = map$lon, lat= map$lat, popup = pop)

nycounties <- geojsonio::geojson_read("counties.geojson",
                                      what = "sp")

