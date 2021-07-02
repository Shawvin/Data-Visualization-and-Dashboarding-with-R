library(tidyverse)

# create a sequence of years

years<-seq(2001,2020,1)

years

# create "fake" data for price

price<-rnorm(20, mean=15, sd=5)

# put data together

fig_data<-tibble("years"=years,"stock_price"=price)

ggplot(fig_data, aes(x=years,y=stock_price)) +
  geom_line()

# make data for the first of two stocks

fig_data$stock_id<-rep("stock_1",20)

stock_1_time_series<-fig_data

# create data for the second company

stock_id<-rep("stock_2",20)

years<-seq(2001,2020,1)

price<-rnorm(20, mean=15, sd=5)

stock_2_time_series<- tibble("stock_id"=stock_id,"years"=years,"stock_price"=price)

# combine with bind_rows()

all_stocks_time_series<-bind_rows(stock_1_time_series,stock_2_time_series)

view(all_stocks_time_series)

# make the plot

ggplot(all_stocks_time_series, aes(x=years,y=stock_price, group=stock_id)) + 
  geom_line()

# modify group, linetype, color and add facet_wrap

ggplot(all_stocks_time_series, aes(x=years,y=stock_price, group=stock_id, linetype=stock_id, color=stock_id)) + 
  geom_line() + 
  facet_wrap(~stock_id)

cel<-read.csv("cel_volden_wiseman-_coursera.csv")

cel$party<-recode(cel$dem, "1"="Democrat", "0"="Republican")

fig_data <- cel %>%
  group_by(party, year) %>%
  summarise("Ideology"=mean(dwnom1,na.rm=T))

view(fig_data)

ggplot(fig_data, aes(x=year,y=Ideology, group=party, color=party))+
  geom_line() +
  scale_color_manual(values=c("blue","red"))