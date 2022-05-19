library(tidyverse)
library(skimr)
library(janitor)
hotel_bookings <- read_csv("hotel_bookings.csv")
head(hotel_bookings)
arrange(hotel_bookings, -is_canceled)
arrange(hotel_bookings, desc(lead_time))  #new!
head(hotel_bookings)
hotel_bookings_v2 <- arrange(hotel_bookings, desc(lead_time))
head(hotel_bookings_v2)
max(hotel_bookings$lead_time)
min(hotel_bookings$lead_time)
mean(hotel_bookings$lead_time)
hotel_bookings_city <- filter(hotel_bookings, hotel_bookings$hotel=="City Hotel")
filter(hotel_bookings, hotel=="City Hotel")
#上面两个呈现的结果是一样的
mean(hotel_bookings_city$lead_time)

hotel_summary <- 
  hotel_bookings %>%
  group_by(hotel) %>%
  summarise(average_lead_time=mean(lead_time),
            min_lead_time=min(lead_time),
            max_lead_time=max(lead_time))

head(hotel_summary)
