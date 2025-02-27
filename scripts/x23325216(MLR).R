#setting seed as per the student id number.
set.seed(23325216) 

#Library
library(dplyr)
library(lmtest) 
library(ggplot2)
library(car)
library(corrplot)
library(caret) 
library(psych)

#Importing the dataset
data <- read.csv('/Users/khamaleshramesh/Downloads/mlr_data/mlr6.csv') 

#Summary
summary(data)
data$x3 <- as.numeric(as.factor(data$x3)) 

#Describe
describe(data)

#Correlation matrix and plot
cor_matrix <- cor(data)
cor_matrix
corrplot(cor_matrix, method = "number")


#Plot diagram
ggplot(data, aes(x = x1, y = y)) +
  geom_point() +
  ggtitle("Scatter Plot of y vs x1")

ggplot(data, aes(x = x2, y = y)) +
  geom_point() +
  ggtitle("Scatter Plot of y vs x2")

ggplot(data, aes(x = x3, y = y)) +
  geom_point() +
  ggtitle("Scatter Plot of y vs x3")

#Checking NaN
sum(is.na(data))

#Setting seed value and Splitting train and test data
set.seed(23325216)  
train_index <- createDataPartition(data$y, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

#Structure of data
str(data)

#Building MLR model1
model1 <- lm(y ~ x1 + x2 + x3, data = train_data)

#summary for model1
summary(model1)

#Building model2 with only x1 and x2
model2 <- lm(y ~ x1 + x2 , data = train_data)

#Summary for model2
summary(model2)


#Plot diagram
ggplot(data = data.frame(fitted = fitted(model2), residuals = residuals(model2)), 
       aes(x = fitted, y = residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals vs. Fitted Values", x = "Fitted Values", y = "Residuals")



#Test for checking  Gauss-Markov assumptions
bp_test <- bptest(model2)
print(bp_test)

qqnorm(residuals(model2))
qqline(residuals(model2), col = "red")

shapiro_test <- shapiro.test(residuals(model2))
print(shapiro_test)

hist(residuals(model2), main = "Residuals Histogram", xlab = "Residuals", col = "lightblue", breaks = 20)

qqnorm(residuals(model2))
qqline(residuals(model2), col = "red", lwd = 2)

vif_values <- vif(model2)
print(vif_values)

dw_test <- dwtest(model2)
print(dw_test)

#Model2 predicition
predictions <- predict(model2, newdata = test_data)

#Metrics
rmse <- sqrt(mean((test_data$y - predictions)^2))                # Root Mean Square Error
mae <- mean(abs(test_data$y - predictions))                      # Mean Absolute Error
mpe <- mean((test_data$y - predictions) / test_data$y) * 100     # Mean Percentage Error
mape <- mean(abs((test_data$y - predictions) / test_data$y)) * 100  # Mean Absolute Percentage Error


cat("Root Mean Square Error (RMSE):", round(rmse, 2), "\n")
cat("Mean Absolute Error (MAE):", round(mae, 2), "\n")
cat("Mean Percentage Error (MPE):", round(mpe, 2), "%\n")
cat("Mean Absolute Percentage Error (MAPE):", round(mape, 2), "%\n")

