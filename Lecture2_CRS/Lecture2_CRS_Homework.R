# Homework
# Reminder: Email assignment .pdf file. Recommended to use RMarkdown, so code and output are all in one place. Email by Monday at 9am. 

# 1) Download the LTER lake shapefiles from the LTER database. Map Lake Mendota. Add a point for the location of the CFL. (Keep these files, we'll use them in future classes)

library(rgdal)
library(sp)
library(raster)
library (tidyverse)

download_link <- 'https://lter.limnology.wisc.edu/file/11669/download?token=tWhRExjmwpMK9caKoMd2VcgKmFln3dKHVTC0mwUBvqg'
temp <- tempfile()
#download.file(download_link,temp)
unzip(temp, exdir = 'Data/NTL_LTER_Yahara_Lakes')
unlink(temp)


yahara_lakes <- readOGR(dsn = 'Data/NTL_LTER_Yahara_Lakes/', layer = 'yld_study_lakes')

lake_mendota <- 
  yahara_lakes[yahara_lakes$SHAIDNAME == 'Lake Mendota',] %>% 
  spTransform(., CRS("+init=epsg:4326 +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

cfl_pt <- 
  data.frame(x = -89.402923, y = 43.077269) %>% 
  SpatialPoints() %>% 
  `crs<-` (crs(lake_mendota))

plot(gridlines(lake_mendota), lty=2)
plot(lake_mendota, col = 'lightblue2', add=TRUE)
plot(cfl_pt, pch = 20, col = 'red', cex = 2, add = TRUE)
#text(labels(gridlines(lake_mendota)))


## OR, using sf and tidyverse

library(sf)
library(tidyverse)

lake_mendota_sf <- 
  st_read(dsn = 'Data/NTL_LTER_Yahara_Lakes/yld_study_lakes.shp') %>% 
  st_transform(crs = c("+init=epsg:4326 +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")) %>%
  filter(SHAIDNAME == 'Lake Mendota')

# Use annotate to add the CFL "by hand"
ggplot() +
  geom_sf(data = lake_mendota_sf, fill = 'lightblue2') +
  annotate("point", x = -89.402923, y = 43.077269, colour = "red", size = 4) +
  labs(x = 'Longitude', y = 'Latitude') +
  theme_bw()


# Make a new sf object for the CFL and add it as a layer. Seems to work without giving grid error...
cfl_sf <- data.frame(x = -89.402923, y = 43.077269) %>% 
  st_as_sf(coords = c("x", "y"), crs = st_crs(lake_mendota_sf))

ggplot() +
  geom_sf(data = lake_mendota_sf, fill = 'lightblue2') +
  geom_sf(data = cfl_sf, colour = "red", size = 4) +
  labs(x = 'Longitude', y = 'Latitude') +
  theme_bw()



# 2) Download the National Land Cover (NLCD) dataset for 2011. Load it into R. What is the CRS? (Keep this data, we'll use it in future classes)

download_link <- 'http://www.landfire.gov/bulk/downloadfile.php?TYPE=nlcd2001v2&FNAME=nlcd_2001_landcover_2011_edition_2014_10_10.zip'

temp <- tempfile()
#download.file(download_link,temp)
unzip(temp, exdir = 'Data/')
unlink(temp)

# 3) What’s the best way to check that CRS of two objects are identical?

if(as.character(crs(lake_mendota)) == as.character(crs(cfl_pt))){
  print("You're in luck, the CRS's are identical!")
}





