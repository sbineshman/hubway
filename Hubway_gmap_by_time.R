#install package to use SQL
#install.packages("sqldf")
library(sqldf)
library(ggplot2)
library(ggplot2)
library(ggmap)

hw_data<-read.csv("201612-hubway-tripdata.csv")

# names(hw_data)
# str(hw_data)

#sql <- 'select strftime("%H",starttime) hr,* from hw_data WHERE strftime("%H",starttime) = "01"'

#using variable to get the sub-query
DF_QRY_BASE=sqldf('select strftime("%H",starttime) hr,* from hw_data')

# str(DF_QRY_BASE)
# names(DF_QRY_BASE)

hr <- '09'
DF_QRY_BASE_FILTER= fn$sqldf("select * from DF_QRY_BASE WHERE hr = '$hr'")
DF_QRY_BASE_FILTER

longitude <- DF_QRY_BASE_FILTER$start.station.longitude
latitude <- DF_QRY_BASE_FILTER$start.station.latitude

basemap <- get_map(location='Boston, USA', zoom = 11, maptype='roadmap',
                   #color='bw', 
                   source='google')

ggmap(basemap)

map1 <- ggmap(basemap, extent='panel', base_layer=ggplot(DF_QRY_BASE_FILTER,aes(x=longitude, y=latitude)))
#print(map1)

# add data points
map.hubway <- map1 + geom_point(color = "blue", size = 2)
# add plot labels
map.hubway <- map.hubway + labs(title="HUBWAY Center",
                                    x="Longitude", y="Latitude")
# add title theme
map.hubway <- map.hubway + theme(plot.title = element_text(hjust = 0,vjust = 1, face = c("bold")))
print(map.hubway)
