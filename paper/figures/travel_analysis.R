
library(fuzzyclara)
library(dplyr)
library(tidyr)
library(ggplot2)

# TODO make the RA dataset part of the package and call it with 'data()'
dat <- readRDS("~/LRZ Sync+Share/TourIST_neu/TourIST_2021-03-07T0005/Paper/7_fuzzyclara/1_RAsampleData/Reiseanalyse_sample.rds")



# data prep ---------------------------------------------------------------
# reformat to long format
dat_long <- dat %>% 
  mutate(traveler_id = 1:nrow(.)) %>% 
  tidyr::pivot_longer(cols = 2:5, names_to = "variable")

# standardize the individual variables
dat_long <- dat_long %>% 
  group_by(variable) %>% 
  mutate(value = scale(value)) %>% 
  ungroup()



# plot unclustered data ---------------------------------------------------
# only plot randomly chosen n travelers
n <- 500
random_ids <- sample(unique(dat_long$traveler_id), size = n)

dat_long %>% 
  filter(traveler_id %in% random_ids) %>% 
  ggplot(aes(x = variable, y = value, group = traveler_id)) + 
  geom_line(alpha = 0.05) +
  ylab("standardized value") +
  theme_minimal(base_size = 12) +
  theme(axis.title.x = element_blank())
ggsave("travel_description.png", bg = "white", width = 5, height = 4)



# cluster data ------------------------------------------------------------
# select number of clusters
choice <- evaluate_cluster_numbers(data           = dat,
                                   clusters_range = 2:10,
                                   metric         = "euclidean",
                                   samples        = 20,
                                   sample_size    = 1000,
                                   type           = "fuzzy",
                                   seed           = 2022,
                                   verbose        = 1,
                                   m              = 1.5,
                                   plot           = TRUE,
                                   return_results = TRUE)
choice$plot
ggsave("travel_ellbow.png", bg = "white", width = 10, height = 4)


dat_long <- dat_long %>% 
  mutate(cluster = paste("Cluster", rep(choice$cluster_results[[5]]$clustering, each = 4)),
         cluster = factor(cluster))
dat_long_medoids <- dat_long %>% 
  filter(traveler_id %in% choice$cluster_results[[5]]$medoids)



# plot clustered data -----------------------------------------------------
# only plot randomly chosen n travelers
n <- 500
set.seed(2022)
random_ids <- sample(unique(dat_long$traveler_id), size = n)

# with highlighted medoids per cluster
ggplot(mapping = aes(x = variable, y = value, group = traveler_id, col = cluster)) +
  geom_line(data = dat_long %>% filter(traveler_id %in% random_ids), alpha = 0.05) +
  geom_line(data = dat_long_medoids, size = 1.5) +
  ylab("standardized value") +
  facet_wrap(~ cluster, nrow = 1) +
  theme_minimal(base_size = 12) +
  theme(axis.title.x    = element_blank(),
        legend.position = "none",
        axis.text.x     = element_text(angle = 45, hjust = 1))
ggsave("travel_clustered.png", bg = "white", width = 10, height = 4)