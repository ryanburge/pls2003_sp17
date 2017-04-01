library(spdplyr)



counties <- rgdal::readOGR("counties.geojson", "OGRGeoJSON")
pal <- colorNumeric("viridis", NULL)

census <- read_dta("D:/2016_election/relcensus.dta")
s.census <- select(census, evanrate, bprtrate, cathrate, ldsrate, orthrate, mprtrate)
s.census[is.na(s.census)]<- 0
s.census$max <- apply(s.census, 1, max)
s.census$fips <- census$fips
s.census$test <- 1308.69 - s.census$max
s.census$test <- s.census$test/1308.69


counties <- counties %>% mutate(fips = paste0(STATE, COUNTY))
div <- select(s.census, fips, test)
div$fips <- sprintf("%05d",div$fips)
map <- left_join(counties, div, by = "fips")

m2 <- map %>% filter(div > .25)


myLabelFormat = function(..., reverse_order = FALSE){ 
  if(reverse_order){ 
    function(type = "numeric", cuts){ 
      cuts <- sort(cuts, decreasing = T)
    } 
  }else{
    labelFormat(...)
  }
}

leaflet(m2) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, weight = 1, smoothFactor = 0.3, fillOpacity = 1, color = "black",
              fillColor = ~pal(m2$div),
              label = ~paste0(NAME, ": ", formatC(m2$div, big.mark = ","))) %>%
  addLegend(pal = pal, values = rev(m2$div), opacity = 1.0, labFormat = myLabelFormat(reverse_order = T)) 


