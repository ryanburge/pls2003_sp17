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


leaflet(map) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, weight = 1, smoothFactor = 0.3, fillOpacity = 1, color = "black",
              fillColor = ~pal(map$test),
              label = ~paste0(NAME, ": ", formatC(map$test, big.mark = ","))) %>%
  addLegend(pal = pal, values = map$test, opacity = 1.0)


