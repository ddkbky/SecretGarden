hotel_bookings <- read.csv("hotel_bookings.csv")
colnames(hotel_bookings)
library(ggplot2)
ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x = lead_time, y = children))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = hotel, fill = market_segment))

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = hotel)) +
  facet_wrap(~market_segment)

library(tidyverse)
onlineta_city_hotels <- filter(hotel_bookings, 
                               (hotel=="City Hotel" & 
                                  hotel_bookings$market_segment=="Online TA"))
View(onlineta_city_hotels)
#filter在最前面，用逻辑符合联结条件

onlineta_city_hotels_v2 <- hotel_bookings %>%
  filter(hotel=="City Hotel") %>%
  filter(market_segment=="Online TA")
View(onlineta_city_hotels_v2)
#pipe的写法

ggplot(data = onlineta_city_hotels_v2) +
  geom_point(mapping = aes(x = lead_time, y = children))

