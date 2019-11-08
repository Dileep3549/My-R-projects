library(ggplot2)
library(lubridate)
library(prophet)

# read data
data<-read.csv("Ethereum.csv", header=T)

data$Date <- dmy(data$Date)
getwd()
setwd("C:\\Users\\dillu\\Documents\\My R project\\My R projects\\Forecasting Crypto Etherium with R")
str(data)

# Log transformation
ds <- data$Date
y <- log(data$Close)
df <- data.frame(ds, y)
# Forecasting with Facebook's prophet package
m <- prophet(df)
future <- make_future_dataframe(m, periods = 365)
forecast <- predict(m, future)


# Plot forecast
plot(m, forecast)
prophet_plot_components(m, forecast)

# Model performance
pred <- forecast$yhat[1:1544]
actual <- m$history$y
plot(actual, pred)

x <- cross_validation(m, 365, units = 'days')
performance_metrics(x, rolling_window = 0.1)
plot_cross_validation_metric(x,
                             metric = 'mae',
                             rolling_window = 0.2)
##added a comment##

