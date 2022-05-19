install.packages("SimDesign")
library(SimDesign)
actual_temp <- c(1,2,3,4,5)
predicted_temp <- c(2,3,4,5,6)
bias(actual_temp, predicted_temp)
#越接近0，代表越准确