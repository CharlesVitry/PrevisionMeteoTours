PredictionBuysBallot <- function(Date){

  Date2 <- Date
return(  round(
    predict(Regression,newdata = data.frame(X = ((as.numeric(format(Date, "%m")) - 1) * (1 / 12) 
                                                 + as.numeric(format(Date, "%Y")))))
    + predict(Regression2, newdata = data.frame(mois = (as.numeric(format(Date2, "%m")) - 1) * (1 / 12)))
  )
)
}
