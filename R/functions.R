checkupRes = function(Res){
  
  # Partitionnement de la fenêtre graphique 
  layout(matrix(c(1,1,1,2:7), nrow=3, ncol=3, byrow=TRUE))
  plot.window(xlim=c(0,length(Res)),ylim=c(min(Res),max(Res)))
  
  # Série des résidus
  plot(Res,type='l', xlab = 'Time', ylab = 'Residuals')
  
  # ACF/PACF
  acf(Res, main="")
  pacf(Res, main="")
  
  # Nuage de points avec décalage de 1 dans le temps
  Res_aux = c()
  
  for (j in 1:length(Res)){
    Res_aux[j] = Res[j-1]
  }
  plot(Res_aux,Res,col='blue', xlab = expression(epsilon[t-1]), ylab = expression(epsilon[t]))
  
  # Histogramme
  hist(Res, freq=FALSE, breaks=30, col='lightblue', xlab = 'Residuals')
  curve(dnorm(x, m=mean(Res), sd=sd(Res)), col="red", lty=2, add=TRUE)
  
  # QQ plots  -> c'est une droite pour les gaussiennes
  qqnorm(Res,col='blue')
  qqline(Res)
  
  # Nuage de points standardisé
  plot((Res-mean(Res))/sd(Res),col='blue',ylab = 'Normalized residuals', xlab = 'Time')
  abline(a=1.96,b=0,col='red')
  abline(a=-1.96,b=0,col='red')
}

check_stat = function(res){
  checkupRes(res[which(!is.na(res))])
  print(Box.test(res, type="Ljung-Box", lag=7))
  print(kpss.test(res))
  print(adf.test(res[which(!is.na(res))]))
  print(shapiro.test(res))
}

evaluate = function(model, trainset){
  print("------- Analyse du model -------")
  print(model)
  plot(trainset)
  lines(model$fitted, col='red')
  print("")
  print("------- Analyse des résidus -------")
  check_stat(model$residuals)
}

getPerformance = function(pred, val) {
  # Compute metrics with y_pred=pred and y_true=val
  res = pred - val
  MAE = sum(abs(res))/length(val)
  MAPE = sum(abs(res)/abs(val)*100)/length(val)
  RSS = sum(res^2)
  MSE = RSS/length(val)
  RMSE = sqrt(MSE)
  perf = data.frame(MAE, MAPE, RSS, MSE, RMSE)
}