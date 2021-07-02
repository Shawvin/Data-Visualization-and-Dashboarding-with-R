library(tidyverse)

cel<-read.csv("cel_volden_wiseman-_coursera.csv")

cel %>% filter(congress==115) %>%
  ggplot(aes(x=dem))+
  geom_bar()

# prove the bar plot is right by comparing with a frequency table
cel %>% filter(congress==115) %>% select(dem) %>% table()

# use st_name instead, so how counts of how many members of congress from each state
cel %>% filter(congress==115) %>%
  ggplot(aes(x=st_name))+
  geom_bar()

# flip the figure by seeting y aesthetic rather than x
cel %>% filter(congress==115) %>%
  ggplot(aes(y=st_name))+
  geom_bar()

# let's go back and recode the dem variable to be a categorical variable
cel$party<-recode(cel$dem, '1'="Democratic",'0'="Republican")

cel %>% filter(congress==115) %>%
  ggplot(aes(x=party))+
  geom_bar() 

# now we add some touches

# add axis labels
cel %>% filter(congress==115) %>%
  ggplot(aes(x=party))+
  geom_bar() +
  labs(x="Party", y="Number of Members")

# Mannually change the colors of the bars
cel %>% filter(congress==115) %>%
  ggplot(aes(x=party,fill=party))+
  geom_bar() +
  labs(x="Party", y="Number of Members") +
  scale_fill_manual(values = c("blue","red"))

# drop the legend
cel %>% filter(congress==115) %>%
  ggplot(aes(x=party,fill=party))+
  geom_bar() +
  labs(x="Party", y="Number of Members") +
  scale_fill_manual(values = c("blue","red")) +
  guides(fill=FALSE)

#### Making more barplots and manipulating more data in R

# Making a barplot of proportions

# a toy demonstration
## a bowl of fruit 
apple<-rep("apple",6)
orange<-rep("orange",3)
banana<-rep("banana",1)

# put together the fruits in a dataframe
# create a single columns with fruits
fruit_bowl=tibble("fruit"=c(apple,orange,banana))

### Let's calculate proportions instead

## create the table that counts fruits in a second column
fruit_bowl_summary<- fruit_bowl %>% 
  group_by(fruit) %>%
  summarize("count"=n())

fruit_bowl_summary

fruit_bowl_summary$proportion<-fruit_bowl_summary$count/sum(fruit_bowl_summary$count)

## add the add_bar, using "stat" to telll command to plot the exact value for proportion
ggplot(fruit_bowl_summary, aes(x=fruit, y=proportion)) + 
  geom_bar(stat="identity")


ggplot(fruit_bowl_summary, aes(x=fruit, y=proportion, fill=fruit)) + 
  geom_bar(stat="identity") + 
  scale_fill_manual(values=c("red","yellow","orange")) +
  guides(fill=FALSE) +
  labs(x="Fruits",y="Proportion of Fruits")

## more practice with barplots
cces$dem_rep<-recode(cces$pid7, '1'="Democrat", '2'="Democrat", '3'="Democrat", '4'="Independent",
                     '5'="Republican", '6'="Republican",'7'="Republican")

table(cces$dem_rep)

## stack bars
ggplot(cces, aes(x=region, fill=dem_rep)) +
  geom_bar()

## grouped bars
ggplot(cces, aes(x=region, fill=dem_rep)) +
  geom_bar(position="dodge")

## visual touches liek relabeling the axes
ggplot(cces, aes(x=region, fill=dem_rep)) +
  geom_bar(position="dodge") +
  labs(x="Region", y="Count")
