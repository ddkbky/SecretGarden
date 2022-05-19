library(ggplot2)
library(palmerpenguins)
ggplot(data = penguins) +
  geom_point(mapping = aes(x= flipper_length_mm, y=body_mass_g, color=species)) +
  facet_wrap(~species)
ggplot(data = penguins, aes(x= flipper_length_mm, y=body_mass_g) +
  geom_point(aes(color=species)) +
  facet_wrap(~species)
#两个一样的，只不过aes放的位置不一样


ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=color, fill=cut)) +
  facet_wrap(~cut)

ggplot(data = penguins) +
  geom_point(mapping = aes(x= flipper_length_mm, y=body_mass_g, color=species)) +
  facet_grid(sex~species)
