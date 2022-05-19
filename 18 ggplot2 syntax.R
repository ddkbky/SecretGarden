hotel_bookings <- read_csv("hotel_bookings.csv")
head(hotel_bookings)
colnames(hotel_bookings)
library(ggplot2)
ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x=stays_in_weekend_nights, y=children))
