library(shiny)
library(tidyverse)

#####Import Data

dat<-read_csv("cces_sample_coursera.csv")
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

# define the UI
ui<-fluidPage(
    sliderInput("ideo",
                "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                min = 1,
                max = 5,
                value = 3),
    plotOutput("congress_plot")
)


server<-function(input,output){
    output$congress_plot <- renderPlot({ 
        dat %>% filter(ideo5==input$ideo) %>% ggplot(aes(x=pid7)) + 
            geom_bar() + 
            labs(x="7 Point Party ID, 1=Very D, 7=Very R") +
            xlim(0, 8) +
            ylim(0, 125)
    })
}

shinyApp(ui,server)