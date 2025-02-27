# Installing the necessary packages
install.packages("forecast")
install.packages("tseries")
install.packages("ggplot2")
install.packages("TSstudio")

#libraries
library(forecast)
library(tseries)
library(ggplot2)
library(TSstudio)

#Import the dataset
data <- read.csv("/Users/khamaleshramesh/Downloads/ts_data/ts6.csv")

#First few rows
head(data)

#Summary
summary(data)

#Describe the data
describe(data)

#Plot diagram
ggplot(data, aes(x = x)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  labs(title = "Histogram of x", x = "x", y = "Frequency")

#Boxplot
ggplot(data, aes(y = x)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot of x", y = "x")

#Structure of data
str(data)

# Creating a time series object by assuming monthly data starting from January 2020
ts_data <- ts(data$x, start = c(2020, 1), frequency = 12)
print(ts_data)

# Plotting the raw time series
plot(ts_data, main = "Raw Time Series Data", xlab = "Time", ylab = "Values")

# Decompose the time series
decomposed <- decompose(ts_data)
plot(decomposed)

#ADF test
adf_test <- adf.test(ts_data)
print(adf_test)

# Apply first differencing.
diff_ts <- diff(ts_data)

decomposed2 <- decompose(diff_ts)
plot(decomposed2)

# Plotting differenced data
plot(diff_ts, main = "Differenced Time Series", xlab = "Time", ylab = "Values")

#ADF test for the diff_ts
adf_test_diff <- adf.test(diff_ts)
print(adf_test_diff)



#Splitting the data into test and train
train_size <- floor(0.8 * length(ts_data))
train_ts <- window(ts_data, end = c(2020, train_size))
test_ts <- window(ts_data, start = c(2020, train_size + 1))

#Fitting auto arima model
fit <- auto.arima(train_ts)

#Summary
summary(fit)

#Diagnostic plots
checkresiduals(fit)

#Forecasting the next periods based on the test data
forecasted <- forecast(fit, h = length(test_ts))

# Plotting the forecasted vs actual data
plot(forecasted, main = "Forecasted vs Actual Time Series")
lines(test_ts, col = 'red', lwd = 2)  # Actual test data in red

#Accuracy of the model
accuracy(forecasted, test_ts)

# ACF and PACF plots for the training data
acf(train_ts, main = "ACF of Training Data")
pacf(train_ts, main = "PACF of Training Data")



