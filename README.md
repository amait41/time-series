# time-series
Study of a time series and implementation of SARIMA-type models.

# Idées
- Ajouter les moyennes journalières en variable exogènes

# Question
- Cmment on calcul la (log-)vraissemblance d'un modèle ? => BIC 
- Pourquoi on ne fait pas de ACF/PACF pour estimer les paramètre p et q d'un modèle SARIMA ? Quand est-il des paramètre P, Q ?
- Pas besoin de regression si on met d ou D > 0 ? => d=3 dans un SARIMA alors la tendance d'ordre 2 est éliminée ?
- bIC 

# Modèles

1. Decompose
2. SARIMA
3. Log + SARIMA
4. Box-Cox + SARIMA => procédure choix du lambda (idem en R et Python = -0.7)

# Étapes
1. Différancier + transfo + reg pour être stationnare
2. Bloquer d et D puis faire auto.arima => 
3. check res + test normalité (shapiro et autres) + test Ljung-Box
4. pred avec CV
5. calcul err final sur testset
6. conclusion
7. ouverture autres modèles et taille trainset
