#install.packages("ggmap")
library(ggplot2)
library(ggmap)

# creating a sample data.frame with your lat/lon points
lat  <- c(42.3515431,42.348706)
lon<- c(-71.04573011, -71.097009)
      
df <- as.data.frame(cbind(lon,lat))

# getting the map
mapgilbert <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 4,
                      maptype = "satellite", scale = 2)

# plotting the map with some points on it
ggmap(mapgilbert) +
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

####################################################################
####################################################################
####################################################################

library(ggplot2)
library(ggmap)
library(maps)

hw_data<-read.csv("201612-hubway-tripdata.csv")

print(hw_data)
names(hw_data)
longitude <- hw_data$start.station.longitude
latitude <- hw_data$start.station.latitude

basemap <- get_map(location='Boston, USA', zoom = 11, maptype='roadmap',
                   #color='bw', 
                   source='google')

ggmap(basemap)

map1 <- ggmap(basemap, extent='panel', base_layer=ggplot(hw_data,aes(x=longitude, y=latitude)))
print(map1)

# add data points
map.villages <- map1 + geom_point(color = "blue", size = 2)
# add plot labels
map.villages <- map.villages + labs(title="HUBWAY Center",
                                      x="Longitude", y="Latitude")
# add title theme
map.villages <- map.villages + theme(plot.title = element_text(hjust = 0,
                                                                 vjust = 1, face = c("bold")))
print(map.villages)
