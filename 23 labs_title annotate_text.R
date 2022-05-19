library(ggplot2)
library(palmerpenguins)
ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, color=species))+
  labs(title = "Palmer Penguins: Flipper length vs. Body Mass", subtitle = "Sample of Three Penguin Species", caption = "Dr. I don't know") +
  annotate("text", x=220, y=3500, label = "The Gentoos are the largest!", color="orange",
           fontface="bold", size=4, angle=30)

p + annotate("rect", xmin = 3, xmax = 4.2, ymin = 12, ymax = 21,
             alpha = .2)
p + annotate("segment", x = 2.5, xend = 4, y = 15, yend = 25,
             colour = "blue")
p + annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28,
             colour = "red", size = 1.5)
p + annotate("text", x = 2:3, y = 20:21, label = c("my label", "label 2"))