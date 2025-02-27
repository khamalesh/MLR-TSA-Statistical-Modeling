# MLR & Time Series Analysis for Data-Driven Decision Making

## Introduction  
This repository provides a comprehensive analysis of two datasets using **Multiple Linear Regression (MLR)** and **Time Series Analysis (TSA)** in R. The MLR section focuses on predicting a continuous variable (`y`) using predictors (`x1`, `x2`, `x3`), while the TSA section forecasts trends in monthly data starting from January 2020.  

## Features  
### **MLR Analysis**  
- **EDA:**  
  - Descriptive statistics, correlation matrices, and scatter plots.  
  - Conversion of categorical variable `x3` to numeric.  
- **Model Development:**  
  - `lm()` for regression modeling.  
  - Stepwise exclusion of insignificant predictors (e.g., `x3`).  
- **Diagnostics:**  
  - Residual analysis (normality, homoscedasticity, independence).  
  - Performance metrics: RMSE (1041.02), MAPE (4.89%).  

### **TSA Analysis**  
- **Decomposition:** Trend, seasonality, and residual extraction.  
- **Stationarity:** Achieved via first differencing (ADF test p-value: 0.01).  
- **ARIMA Modeling:** Auto-selected `ARIMA(0,1,0)` for forecasting.  
- **Forecast Evaluation:** Test-set MAPE of 15.64%.  

## Installation  
1. **R Environment:** Ensure R (≥4.0.0) and RStudio are installed.  
2. **Dependencies:** Run the following in R:  

install.packages(c(
  "dplyr", "lmtest", "ggplot2", "car", 
  "corrplot", "caret", "psych", 
  "forecast", "tseries", "TSstudio"
))
