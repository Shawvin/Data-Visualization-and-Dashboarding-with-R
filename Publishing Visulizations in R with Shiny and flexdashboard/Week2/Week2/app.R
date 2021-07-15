library(shiny)
library(tidyverse)
library(plotly)
library(DT)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)

ui <- navbarPage(
    title="My Application",
    tabPanel("Page 1",
             
             sidebarLayout(
                 sidebarPanel(
                     sliderInput(
                         inputId="ideo",
                         label="Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                         min=1,
                         max=5,
                         value=3,
                         sep="")
                 ),
                 mainPanel(
                     tabsetPanel(
                         tabPanel("Tab 1", plotOutput("plot1")), 
                         tabPanel("Tab 2", plotOutput("plot2"))
                     )
                 )
                 )
             ),
    
    tabPanel("Page 2",
             
             sidebarLayout(
                 sidebarPanel(
                     checkboxGroupInput(inputId="gender1",
                                        label="Select Gender",
                                        choices=c(1,2)
                     )
                 ),
                 
                 mainPanel(
                     plotlyOutput("plot3")
                 )
             )
             
             ),
    
    tabPanel("Page 3",
             
             sidebarLayout(
                 sidebarPanel(
                     selectInput(
                         inputId="region1",
                         label="Select Region",
                         choices=c(1,2,3,4),
                         selected=NULL,
                         multiple=TRUE
                     )
                 ),
                 
                 mainPanel(
                     dataTableOutput("plot4")
                 )
             )
             )
)

server<-function(input,output){
    output$plot1<-renderPlot({
        dat %>% filter(ideo5==input$ideo) %>% ggplot(aes(x=pid7)) + 
            geom_bar() +
            xlim(0, 8) +
            ylim(0, 100) +
            labs(x="7 Point Party ID, 1=Very D, 7=Very R", y="Count")

    })
    
    output$plot2<-renderPlot({
        dat %>% filter(ideo5==input$ideo) %>% ggplot(aes(x=CC18_308a)) + 
            geom_bar() +
            xlim(0, 5) +
            labs(x="Trump support", y="Count")
        
    })
    
    output$plot3<-renderPlotly({
        dat %>% filter(gender %in% input$gender1) %>% ggplot(aes(x=educ,y=pid7)) + 
            geom_jitter() +
            geom_smooth(method="lm")
        
    })
    
    output$plot4<-renderDataTable({
        dat %>% filter(region %in% input$region1)
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
