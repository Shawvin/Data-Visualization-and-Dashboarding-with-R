library(tidyverse)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
data <- expand.grid(X=x, Y=y)
data$Z <- runif(400, 0, 5)

ggplot(data, aes(x=X,y=Y,fill=Z)) +
  geom_tile()

# practice again using a more substantive example
players<-c("Michael","Lebron","Kobe")
points<-c(35,40,45)
assists<-c(10,12,5)
rebounds<-c(15,12,5)

basketball<-data.frame(players,points,assists,rebounds)

# standardize the values
basketball$standardize_points<-basketball$points/max(basketball$points)
basketball$standardize_assists<-basketball$assists/max(basketball$assists)
basketball$standardize_rebounds<-basketball$rebounds/max(basketball$rebounds)

basketball_standardize<-select(basketball, players, standardize_points, standardize_assists, standardize_rebounds)

long_basketball_scale<-gather(basketball_standardize, "stat","value",-players)

ggplot(long_basketball_scale, aes(x=players, y=stat,fill=value)) +
  geom_tile()

