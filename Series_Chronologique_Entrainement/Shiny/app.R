library(shiny)

#Import Données Préparés en Amont
RegressionAnnees <- readRDS(file = "./Shiny/RegressionAnnees.rda")
RegressionMois <- readRDS(file = "./Shiny/RegressionMois.rda")

#Source Fonction de Prediction
source("./Shiny/Prediction.R")

#Lancement du serveur
runApp("Shiny", launch.browser=TRUE)
