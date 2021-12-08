library(MLmetrics)
help(MLmetrics)
decomp = function(trainset, testset){
  n1 = length(trainset)
  n2 = length(testset)
  # Fit decompose and apply reg lin on trend
  decomp = decompose(trainset)
  t = 1:n1
  t2 = t**2
  t3 = t**3
  reg_lin = lm(decomp$trend ~ t + t2 + t3)
  train_trend = reg_lin$coefficients[1] + t * reg_lin$coefficients[2] + t2 * reg_lin$coefficients[3] + t3 * reg_lin$coefficients[4]
  train_seasonal = decomp$seasonal
  # Predict with h = length(testset)
  x = (n1 + 1) : (n1 + n2)
  x2 = x**2
  x3 = x**3
  pred_trend = reg_lin$coefficients[1] + x * reg_lin$coefficients[2] + x2 * reg_lin$coefficients[3] + x3 * reg_lin$coefficients[4]
  if (n2%%7==0){
    pred_seasonal = c(rep(decomp$figure, n2%/%7))
  }else{
    pred_seasonal = c(rep(decomp$figure, n2%/%7), decomp$figure[1:n2%%7])
  }
  # pred_trend+pred_seasonal
  list("train"=train_trend+train_seasonal, "pred"=pred_trend+pred_seasonal)
}

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

getPerformance = function(y_pred, y_true) {
  # Compute metrics with y_pred and y_true
  MAE = MAE(y_pred, y_true)
  MAPE = MAPE(y_pred, y_true)
  MSE = MSE(y_pred, y_true)
  RMSE = RMSE(y_pred, y_true)
  perf = data.frame(MAE, MAPE, MSE, RMSE)
}