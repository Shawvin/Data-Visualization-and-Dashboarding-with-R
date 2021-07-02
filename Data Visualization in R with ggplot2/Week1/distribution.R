library(tidyverse)

cces=read.csv("cces_sample_coursera.csv")

## check the data
head(cces)

## boxplots

## make a basic boxplot
ggplot(cces,aes(y=faminc_new))+geom_boxplot()

## break up boxplots by education group -- add a aesthetic mapping for group
ggplot(cces,aes(y=faminc_new,group=educ))+
  geom_boxplot()

## add label and title
ggplot(cces,aes(y=faminc_new,group=educ))+
  geom_boxplot() +
  labs(x="Income Level", y="Family Income", title="Family Inc. by respondent Ed. level")

## reformat the data to create a dichotomous categorical variable for four year college grades or more, and then all repsondents with 2 year college degrees or less

cces$edu_cat<-recode(cces$educ,'1'='<4 yr Degree','2'='<4 yr Degree','3'='<4 yr Degree',
                     '4'='<4 yr Degree','5'=' 4 yr Deg. +','6'=' 4 yr Deg. +')

## make sure you change the anesthetic mapping so the new categorical variable is mapped to "x" rather than "group"
ggplot(cces,aes(y=faminc_new,x=edu_cat))+
  geom_boxplot() +
  labs(x="Income Level", y="Family Income", title="Family Inc. by respondent Ed. level")

# make a histogram
ggplot(cces, aes(x=faminc_new)) +
  geom_histogram()

# make a density plot
ggplot(cces, aes(x=faminc_new)) +
  geom_density()