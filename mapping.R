library(ggmap)
library(leaflet)
library(rvest)
library(xml2)


geo <- data.frame("location" =c("One World Trade NYC", "Willis Tower", "Mar-a-Lago", "Corn Palace"), count = c(1,2,3,5))





url <- "https://en.wikipedia.org/wiki/List_of_rallies_for_the_Donald_Trump_presidential_campaign,_2016"
trump <- url %>%
  html() %>%
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


map<-leaflet()%>%
  addTiles()%>%
  addCircleMarkers(lng = mapdf$lon, lat= mapdf$lat, radius = mapdf$crowd/1000, fillColor = "firebrick3", fillOpacity=0.3, weight=1, color="firebrick3", popup = pop)

