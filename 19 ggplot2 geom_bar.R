library(ggplot2)
data("diamonds")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut))
#如果没标明y轴，就是计数count

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, color = cut))
#color给bar加边框，fill给bar填充颜色
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill = clarity))
#当fill的条件变成另一个variable时，变成堆积柱状图

