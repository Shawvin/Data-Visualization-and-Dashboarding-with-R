library(tidyverse)

## Load the data
cel<-read.csv("cel_volden_wiseman-_coursera.csv")

names(cel)
dim(cel)
table(cel$year)
summary(cel$all_bills)

# for making a scatterplot
fig115<-filter(cel,congress==115) %>% select("seniority","all_pass")

# chekc to make sure the filter worked properly
head(fig115)

# set up the data and aesthetics
ggplot(fig115, aes(x=seniority, y=all_pass))

# add the marks
ggplot(fig115, aes(x=seniority, y=all_pass)) + 
  geom_point()

# jitter adds random noise to the data to avoid overplotting
ggplot(fig115, aes(x=seniority, y=all_pass)) + 
  geom_jitter()

# add some lables and title
ggplot(fig115, aes(x=seniority, y=all_pass)) + 
  geom_jitter() +
  labs(x="Seniority", y="Bills passed", title="Seniority and Bills Passed in the 115th Congress")

# modify filter and select to grab dem
fig115<-filter(cel,congress==115) %>% select("seniority","all_pass", "dem")

ggplot(fig115, aes(x=seniority, y=all_pass, color=dem)) + 
  geom_jitter() +
  labs(x="Seniority", y="Bills passed", title="Seniority and Bills Passed in the 115th Congress")

# make dem a categorical variable called "party"
fig115$party=as.factor(fig115$dem)

fig115$party

levels(fig115$party)=c("Republican","Democrat")

fig115$party

# let's make traditional blue democrats and red republicans
ggplot(fig115, aes(x=seniority, y=all_pass, color=party)) + 
  geom_jitter() +
  labs(x="Seniority", y="Bills passed", title="Seniority and Bills Passed in the 115th Congress") +
  scale_colour_manual(values=c("red","blue"))

# make two seperate plots using facet_wrap 
ggplot(fig115, aes(x=seniority, y=all_pass, color=party)) + 
  geom_jitter() +
  labs(x="Seniority", y="Bills passed", title="Seniority and Bills Passed in the 115th Congress") +
  scale_colour_manual(values=c("red","blue")) +
  facet_wrap(.~party)
