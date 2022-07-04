#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Prévision Trafic"),
    

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          
            
            dateInput("date", label = h3("Rentrez le mois à prédire"), value = "2019-01-01"),
            
            hr(),
            fluidRow(column(10, verbatimTextOutput("value"))),
            h3("Prédiction du trafic futur"),
            textOutput("Prediction")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h1("Prédiction du trafic (en bleu)"),
          p("Observons la qualité de nos estimations par rapport aux données réelles"),
          img(src = "BuysBallotPlotPrediction.png",height = 400 , width = 800),
          div(),
      h1("Les mois les plus importants en terme de trafic"),
      p("Observons quels mois sont les plus demandeurs en moyens"),
           img(src = "SeasonPlot.png",height = 400 , width = 800)
     
            
            
            
            )
    )
))
