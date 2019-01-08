#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("script ggplot.R")


#Update<-download.monex()
#DATA<-rbind(DATA,Update)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
           
  output$Plot <- renderPlot({
          
          MONEX_Diario(inicio=input$initial, WA=input$wa, Volume = input$volume, Transactions = input$num)
  })
  
})
