library(tidyverse)
library(RColorBrewer)
library(ggthemes)

cces<-read.csv("cces_sample_coursera.csv")

# make a small data set with variables
plot_data<-select(cces, "CC18_308a","ideo5","educ","faminc_new","employ") %>% drop_na()

ggplot(plot_data, aes(y=CC18_308a,x=ideo5)) + 
  geom_jitter()

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=educ, size=faminc_new)) + 
  geom_jitter()

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=educ, size=faminc_new)) + 
  geom_jitter() +
  # use scale_color_gradient here to show continuous change in a numeric variable
  scale_color_gradient(low="gray",high="purple")

# Use employment as categorical variable

plot_data$employ_cat<-recode(plot_data$employ, '1'="Full-time",'2'="part-time",
                             '3'="Temp. Layoff", '4'="Unemployed", '5'="Retired",
                             '6'="Disabled",'7'="Homemaker", '8'="Student", '9'="Other")

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=employ_cat)) + 
  geom_jitter() +
  scale_color_brewer(palette = "RdYlGn")

# rename the employ_cat column
plot_data<-rename(plot_data,'Employment'=employ_cat)

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=Employment)) + 
  geom_jitter() +
  scale_color_brewer(name="Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=90,hjust=1,color = "blue"))

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=Employment)) + 
  geom_jitter() +
  scale_color_brewer(name="Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=90,hjust=1,color = "blue"),
        axis.title = element_text(color="red"))+
  labs(x="Ideology", y="Trump Approval",
       title="Trump Approval, Ideology, and Employment", 
       caption = "A caption might have a quick note about the figure or a sourcing.")

# Add axis label and modify the text

ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=Employment)) + 
  geom_jitter() +
  scale_color_brewer(name="Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=90,hjust=1,color = "blue"),
        axis.title = element_text(color="red"),
        legend.title = element_text(color="green"))+
  labs(x="Ideology", y="Trump Approval",
       title="Trump Approval, Ideology, and Employment", 
       caption = "A caption might have a quick note about the figure or a sourcing.")

## ggthemes contains pre-baked themes that you can try and modify 
ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=Employment)) + 
  geom_jitter() +
  theme_wsj()

# you can still control elements of a pre-baked ggtheme
ggplot(plot_data, aes(y=CC18_308a,x=ideo5, color=Employment)) + 
  geom_jitter() +
  theme_wsj() +
  theme(axis.text=element_text(angle = 90))
