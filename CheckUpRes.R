checkupRes = function(Res){
  
  # Partitionnement de la fenêtre graphique 
  layout(matrix(c(1,1,1,2:7), nrow=3, ncol=3, byrow=TRUE))
  plot.window(xlim=c(0,length(Res)),ylim=c(min(Res),max(Res)))
  
  # Série des résidus
  plot(Res,type='l', xlab = 'Time', ylab = 'Residuals')
  
  # ACF/PACF
  acf(Res)
  pacf(Res)
  
  # Nuage de points avec décalage de 1 dans le temps
  Res_aux = c()
  
  for (j in 1:length(Res)){
    Res_aux[j] = Res[j-1]
  }
  plot(Res_aux,Res,col='blue', xlab = expression(epsilon[t-1]), ylab = expression(epsilon[t]))
  
  # Histogramme
  hist(Res, freq=FALSE, breaks=sqrt(length(Res)),col='lightblue',xlab = 'Residuals')
  curve(dnorm(x, m=mean(Res), sd=sd(Res)), col='red', lty=2, add=TRUE)
  
  # QQ plots  -> c'est une droite pour les gaussiennes
  qqnorm(Res,col='blue')
  qqline(Res)
  
  # Nuage de points standardisé
  plot((Res-mean(Res))/sd(Res),col='blue',ylab = 'Normalized residuals', xlab = 'Time', type='p')
  abline(a=1.96,b=0,col='red')
  abline(a=-1.96,b=0,col='red')
}