#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  DateEntree <- reactive({
    print(input$date)
   as.Date( input$date)
  })
  

  output$Prediction <- renderText({ 
    paste("L'estimation de ",
          format(DateEntree(), "%b %y"),
          " est de ",
          PredictionBuysBallot(DateEntree()),
            " voyageurs")
  })

})
