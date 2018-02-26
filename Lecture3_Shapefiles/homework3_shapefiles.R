library(sf)
library(tidyverse)


# Make a 500 m buffer of the 4 southern LTER lakes. Which buffers overlap?
  
yahara_lakes_sf <- 
  st_read(dsn = "/Users/tylerhoecker/GitHub/Zoo955_fork/Data/NTL_LTER_Yahara_Lakes/yld_study_lakes.shp") 

yahara_buffers <- yahara_lakes_sf %>% 
  st_buffer(dist = 500)

# Add labels at the center of each polygon so that the intersects results make sense
yahara_lakes_coords <- yahara_lakes_sf %>%
  st_centroid() %>%         # find polygon centroids (sf points object)
  st_coordinates()         # extract the coordinates of these points as a matrix

# Insert centroid long and lat fields as attributes of polygons
yahara_lakes_sf$label_long <- yahara_lakes_coords[,1]
yahara_lakes_sf$label_lat <- yahara_lakes_coords[,2]
# Also make an explicit column for their ID, since I can't figure out how to reference that...
yahara_lakes_sf$label <- c("1","2","3","4")

# Use annotate to add the CFL "by hand"
ggplot() +
  geom_sf(data = yahara_buffers, fill = 'grey40', alpha = 0.4) +
  geom_sf(data = yahara_lakes_sf, fill = 'lightblue2') +
  geom_text(data = yahara_lakes_sf, aes(label_long, label_lat, label= label)) +  
  labs(x = 'Longitude', y = 'Latitude') +
  theme_bw(base_size = 14)

# Which ones overlap?
st_overlaps(yahara_buffers, yahara_buffers)


# [This question is considerably more difficult] Increase the size of the lakes by 2x. What is the percent of Mendota that overlaps with Monona?
geom_lakes <- st_geometry(yahara_lakes_sf)

yahara_lakes_sf <- 
  st_read(dsn = "/Users/tylerhoecker/GitHub/Zoo955_fork/Data/NTL_LTER_Yahara_Lakes/yld_study_lakes.shp") 

plot(yahara_lakes_sf)

 
st_geometry(yahara_lakes_sf)[[]][[1]][1,1]


<- st_geometry(st_centroid(yahara_lakes_sf))

plot(yahara_lakes_sf)

cDist <- 2*geom_lakes - cent_lakes 


yahara_centroids <- yahara_lakes_sf %>%
  st_centroid()
  `st_geometry<-` 
   
ggplot() +
  geom_sf(data = yahara_buffers, fill = 'grey40', alpha = 0.4) +
  geom_sf(data = yahara_lakes_sf, fill = 'lightblue2') +
  geom_sf(data = yahara_centroids) +
  #geom_text(data = yahara_lakes_sf, aes(label_long, label_lat, label= label)) +  
  labs(x = 'Longitude', y = 'Latitude') +
  theme_bw(base_size = 14)

yahara_lakes_sf$geometry[[1]] - yahara_centroids$geometry[[1]]

cent_coords <- yahara_centroids[1,] %>% 
  group_by(LAKE_NAME) %>%
  st_coordinates()

edge_coords <- yahara_lakes_sf[1,] %>% 
  group_by(LAKE_NAME) %>%
  st_coordinates() %>% 
  mutate(X_dist = X - cent_coords[,'X'])

edge_coords[,'X_dist'] <- 


dist=sqrt(( coords$X - center[1] )^2 +( coords$Y-center[2])^2)


d$centroids <- st_transform(d, 29101) %>% 
  st_centroid() %>% 
  # this is the crs from d, which has no EPSG code:
  st_transform(., '+proj=longlat +ellps=GRS80 +no_defs') %>%
  # since you want the centroids in a second geometry col:
  st_geometry()

ggplot() +
  geom_sf(data = yahara_2x, fill = 'lightblue2') +
  #geom_sf(data = yahara_buffer2x, fill = 'lightblue2') +
  #geom_text(data = yahara_lakes_sf, aes(label_long, label_lat, label= label)) +  
  labs(x = 'Longitude', y = 'Latitude') +
  theme_bw(base_size = 14)




yahara_lakes_sf$centroid <- yahara_lakes_sf %>% 
  `st_crs<-`("+proj=tmerc +lat_0=0 +lon_0=-90 +k=0.9996 +x_0=520000 +y_0=-4480000 +ellps=GRS80 +units=m +no_defs") %>% 
  st_centroid() 











# Can't figure out how to extract only the overlap among geometries without the overlaps on themselves, without specifying them individually, like:
overlaps <- st_intersection(st_union(yahara_buffers[2,]),st_union(yahara_buffers[3,]))

intersects <- st_intersects(yahara_buffers, yahara_buffers)

overlaps <- st_intersection(yahara_buffers[,],yahara_buffers[,])

overlaps <- st_join(yahara_buffers, yahara_buffers, join = st_overlaps, left = F)

plot(overlaps, col = 'red')

st_union(yahara_buffers)

ggplot() +
  geom_sf(data = st_intersection(yahara_buffers,yahara_buffers))

