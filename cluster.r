## Install libraries
library(tidyverse)
library(RColorBrewer) 
library(sf)
library(dplyr)
library(corrplot)
library(ggplot2) 
library(factoextra) 
library(reshape)
library(gridExtra)
library(tmap)
library(cluster)

## Import data
data.original <- st_read("PRS_EPC_OA_counts_over5.shp")

## Clean data
### Rename columns
colnames(data.original) <- c("OA21CD","LOCAL_AUTHORITY", "count_EPC",
                    "count_current_D","count_current_E","count_current_F", "count_current_G",
                    "count_potential_D","count_potential_E", "count_potential_F","count_potential_G",
                    "count_terrace_end", "count_terrace_enclosedend","count_terrace_mid","count_terrace_enclosedmid",
                    "count_semidetached","count_detached", "count_house", "count_bungalow","count_flat",
                    "count_maisonette", "count_parkhome", "count_mainsgas",
                    "count_pre1900", "count_since2012",
                    "count_hotwaterpoor","count_hotwaterverypoor", "count_wallspoor","count_wallsverypoor", "count_mainheatpoor", "count_mainheatverypoor",
                    "count_current_DandBelow", "count_potential_DandBelow", "count_current_FandBelow", "count_potential_FandBelow", 
                    "count_allterrace", "count_housebungalow", "count_flatmaisonette", 
                    "count_hotwaterall",  "count_wallsall", "count_mainsheatall", 
                    "count_census_all", "geometry")

### Replace NA values
data.original[is.na(data.original)] <- 0

### Create z-scores
cluster.data.df <- data.original %>%
  as_tibble() %>%
  mutate(z_privaterent = scale((count_EPC/count_census_all)*100),
        z_mainsgas  = scale((count_mainsgas/count_census_all)*100),
        z_pre1900 = scale((count_pre1900/count_census_all)*100),
        z_current_DandBelow = scale((count_current_DandBelow/count_census_all)*100),
        z_potential_DandBelow = scale((count_potential_DandBelow/count_census_all)*100),
        z_current_FandBelow = scale((count_current_FandBelow/count_census_all)*100),
        z_potential_FandBelow = scale((count_potential_FandBelow/count_census_all)*100),
        z_allterrace = scale((count_allterrace/count_census_all)*100),
        z_housebungalow = scale((count_housebungalow/count_census_all)*100),
        z_flatmaisonette = scale((count_flatmaisonette/count_census_all)*100),
        z_hotwaterall = scale((count_hotwaterall/count_census_all)*100),
        z_wallsall = scale((count_wallsall/count_census_all)*100),
        z_mainsheatall = scale((count_mainsheatall/count_census_all)*100)) %>%
  select(OA21CD, z_privaterent, z_mainsgas, z_pre1900,
         z_current_DandBelow, z_potential_DandBelow, z_current_FandBelow, z_potential_FandBelow,
         z_allterrace, z_housebungalow, z_flatmaisonette,
         z_hotwaterall, z_wallsall, z_mainsheatall, geometry)

### Rename columns 
colnames(cluster.data.df) <- c("OA Code", "Count of properties", "Mains gas", "Pre 1900", "D and below current", "D and below potential", "F and below current", "F and below potential", "Terrace", "House or bungalow", "Flat or maisonette", "Inefficient hot water", "Inefficient walls", "Inefficient mains heating")

## Visualise relationships between variables
### Generate a corrplot
corr = cor(cluster.data.df[2:14], method = "pearson")
corrplot(corr, 
         type="upper",
         col=brewer.pal(n=8, name="RdYlBu"),
         sig.level = 0.01,
         tl.col = "black",
         order = c("alphabet"))

### Generate a wss and bss plot
wss <- NULL
# finding the tot.withinss for 15 kmeans models
for (i in 1:20) wss[i] <- kmeans(cluster.data.df[2:14], centers = i, iter.max = 1000)$tot.withinss

bss <- NULL
for (i in 1:20) bss[i] <- kmeans(cluster.data.df[2:14], centers = i, iter.max = 1000)$betweenss
plot(1:20, bss, type = "b", pch = 19, xlab = "Number of Clusters",
ylab = "The between-cluster sum of squares", ,)

## K-means clustering
### Generate clusters for k9 - k 14
kmeans_6 <- kmeans(cluster.data.df[2:14], 6, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_7 <- kmeans(cluster.data.df[2:14], 7, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_8 <- kmeans(cluster.data.df[2:14], 8, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_9 <- kmeans(cluster.data.df[2:14], 9, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_10 <- kmeans(cluster.data.df[2:14], 10, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_11 <- kmeans(cluster.data.df[2:14], 11, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_12 <- kmeans(cluster.data.df[2:14], 12, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_13 <- kmeans(cluster.data.df[2:14], 13, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_14 <- kmeans(cluster.data.df[2:14], 14, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_15 <- kmeans(cluster.data.df[2:14], 15, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_16 <- kmeans(cluster.data.df[2:14], 16, 
                      iter.max = 1000, 
                      algorithm = 'MacQueen')

kmeans_6$size
kmeans_7$size
kmeans_8$size
kmeans_9$size 
kmeans_10$size
kmeans_11$size
kmeans_12$size
kmeans_13$size
kmeans_14$size
kmeans_15$size
kmeans_16$size

### Identify centres
centers_6 <- as.matrix(kmeans_6$centers)
centers_6 <- as.data.frame(centers_6)

centers_7 <- as.matrix(kmeans_7$centers)
centers_7 <- as.data.frame(centers_7)

centers_8 <- as.matrix(kmeans_8$centers)
centers_8 <- as.data.frame(centers_8)

centers_9 <- as.matrix(kmeans_9$centers)
centers_9 <- as.data.frame(centers_9)

centers_10 <- as.matrix(kmeans_10$centers)
centers_10 <- as.data.frame(centers_10)

centers_11 <- as.matrix(kmeans_11$centers)
centers_11 <- as.data.frame(centers_11)

centers_12 <- as.matrix(kmeans_12$centers)
centers_12 <- as.data.frame(centers_12)

centers_13 <- as.matrix(kmeans_13$centers)
centers_13 <- as.data.frame(centers_13)

centers_14 <- as.matrix(kmeans_14$centers)
centers_14 <- as.data.frame(centers_14)

centers_15 <- as.matrix(kmeans_14$centers)
centers_15 <- as.data.frame(centers_14)

centers_16 <- as.matrix(kmeans_16$centers)
centers_16 <- as.data.frame(centers_16)

### Map distribution of clusters
p7 <- fviz_cluster(kmeans_7, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 7")
p8 <- fviz_cluster(kmeans_8, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 8")
p9 <- fviz_cluster(kmeans_9, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 9")
p10 <- fviz_cluster(kmeans_10, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 10")
p11 <- fviz_cluster(kmeans_11, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 11")
p12 <- fviz_cluster(kmeans_12, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 12")
p13 <- fviz_cluster(kmeans_13, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
              geom = "point") + ggtitle("k = 13")
p14 <- fviz_cluster(kmeans_14, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 14")
p15 <- fviz_cluster(kmeans_15, data = cluster.data.df[2:14], legend = "none", 
             ellipse = F, pch = 19, pointsize = 0, ggtheme = theme_classic(),
             xlab = "", ylab = "", geom = "point") + ggtitle("k = 15")

grid.arrange(p7, p8, p9, p10, p11, p12, p13, p14, p15, nrow = 3)

### Chart of mean values 
clusters_mvalues <- aggregate(cluster.data.df[2:14], by=list(kmeans_14$cluster),FUN=mean)
clusters_mvalues_n <- as.data.frame(clusters_mvalues[,])
  
means <- melt(clusters_mvalues_n ,  id = "Group.1", variable_name = "Variables")

ggmeans <- ggplot(means, aes(Group.1, value)) + geom_line(aes(colour = Variables)) + 
  scale_x_continuous(breaks=seq(1, 13, by=1)) + theme(text = element_text(size=20))
  ggmeans + ggtitle("Mean variation within clusters")

### Heat map of cluster centers
cluster <- c(1: 9)
center <- kmeans_9$centers
center
center_df <- data.frame(cluster, center)
center_reshape <- gather(center_df, features, values, Count.of.properties:Inefficient.mains.heating)
                         
center_reshape <- center_reshape %>%
    mutate(features = recode(features, "Count.of.properties" = "Count of properties",
                         "Mains.gas" = "Mains gas",
                         "Pre.1900" = "Pre 1990",
                         "D.and.below.current" = "Current rating D and below",
                         "D.and.below.potential" = "Potential rating D and below",
                         "F.and.below.current" = "Current rating F and below",
                         "F.and.below.potential" = "Potential rating F and below",
                         "Terrace" = "Terrace",
                         "House.or.bungalow" = "House or bungalow",
                         "Flat.or.maisonette" = "Flat or maisonette",
                         "Inefficient.hot.water" = "Inefficient hot water",
                         "Inefficient.walls" = "Inefficient walls",
                         "Inefficient.mains.heating" = "Inefficient mains heating"))

#### Create the palette
hm.palette <-colorRampPalette(brewer.pal(9, 'Blues'), space='Lab')

ggplot(data = center_reshape, aes(x = features, y = cluster, fill = values)) +
    scale_y_continuous(breaks = seq(1, 14, by = 1)) +
    geom_tile() +
    coord_equal() +
    scale_fill_gradientn(colours = hm.palette(90)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

## Visualise cluster results
### Polar chart for nine clusters
colnames(centers_9) <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M")
centers_9$Cluster <- seq.int(nrow(centers_9))
centers_9_long <- pivot_longer(centers_9, cols= 1:13, names_to = "Variable", values_to = "Value")

centers_9_long_1 <- centers_9_long %>%
  filter(Cluster == 1)

c1 <- ggplot(centers_9_long_1, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_text(size = 13, face = "bold"),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 1")

centers_9_long_2 <- centers_9_long %>%
  filter(Cluster == 2)

c2 <- ggplot(centers_9_long_2, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 2") 

centers_9_long_3 <- centers_9_long %>%
  filter(Cluster == 3)

c3 <- ggplot(centers_9_long_3, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 3")

centers_9_long_4 <- centers_9_long %>%
  filter(Cluster == 4)

c4 <- ggplot(centers_9_long_4, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_text(size = 13, face = "bold"),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 4") 

centers_9_long_5 <- centers_9_long %>%
  filter(Cluster == 5)

c5 <- ggplot(centers_9_long_5, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 5") 

centers_9_long_6 <- centers_9_long %>%
  filter(Cluster == 6)

c6 <- ggplot(centers_9_long_6, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 6")

centers_9_long_7 <- centers_9_long %>%
  filter(Cluster == 7)

c7 <- ggplot(centers_9_long_7, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_text(size = 13, face = "bold"),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 7") 

centers_9_long_8 <- centers_9_long %>%
  filter(Cluster == 8)

c8 <- ggplot(centers_9_long_8, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 8") 

centers_9_long_9 <- centers_9_long %>%
  filter(Cluster == 9)

c9 <- ggplot(centers_9_long_9, aes(x = Variable, y = Value, 
                             xend = Variable, yend = 0,
           col = Value >= 0))+
  geom_segment(linewidth = 2)+
  scale_y_continuous(limits=c(-1, 8))+
  theme_minimal()+
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        plot.margin = margin(1,1,1,1))+
  coord_polar("x")+
  labs(title = "Cluster 9") 

grid.arrange(c1, c2, c3, c4, c5, c6, c7, c8, c9, nrow = 3)

## Export geopackage
### Add cluster information to original data
OA_data_centroids <- cluster.data.df %>%
  mutate(cluster_6 = kmeans_6$cluster,
         cluster_7 = kmeans_7$cluster,
         cluster_8 = kmeans_8$cluster,
         cluster_9 = kmeans_9$cluster,
         cluster_10 = kmeans_10$cluster,
         cluster_11 = kmeans_11$cluster)

OA_data_centroids_sf <- st_as_sf(OA_data_centroids)

st_write(OA_data_centroids_sf, "OA_clusters.gpkg")
