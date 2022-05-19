library(ggplot2)
library(palmerpenguins)

ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, color =species, shape = species, size = species)) 

ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, alpha = species))
#变换透明度

ggplot(data = penguins) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g),color = "purple")
#将所有点变色，则在aes外面加元素

ggplot(data = penguins) +
  geom_smooth(mapping = aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g))
#同一张图同时有散点和曲线图

ggplot(data = penguins) +
  geom_smooth(mapping = aes(x=flipper_length_mm, y=body_mass_g, linetype = species))

ggplot(data = penguins) +
  geom_jitter(mapping = aes(x=flipper_length_mm, y=body_mass_g))
#jitter作散点图，分散每个点，降低点的重合度，使之更容易查询