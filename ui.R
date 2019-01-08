library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Costarican Colon Exchange Rate Monitor"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        dateInput("initial", "1. Initial Date", "2018-09-01", "2007-12-06",
                  "2018-12-01"),
       checkboxInput("wa", "2. Weighted Averrage", FALSE),
       checkboxInput("volume", "3. Volume: US$ million", FALSE),
       checkboxInput("num", "4. Number of transactions", FALSE)
           ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot"),
       includeHTML("User_information.html")
       
       
    )
  )
))
