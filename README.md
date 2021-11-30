# time-series
Study of a time series and implementation of SARIMA-type models.

# Idées
- Ajouter les moyennes journalières en variable exogènes ou autre ?

# Questions
- Comment on calcul la (log-)vraissemblance d'un modèle ? => BIC et AIC score de parcimonie ?
- Pourquoi on ne fait pas de ACF/PACF pour estimer les paramètre p et q d'un modèle SARIMA ? Quand est-il des paramètre P, Q ?
  Car losqu'on a un pic, il n'est pas évident de savoir si il doit être traité par un paramètre "ARMA" ou "saisonnier" ?
- Pas besoin de regression si on met d ou D > 0 ? => d=3 dans un SARIMA alors la tendance d'ordre 2 est éliminée ?
  Soit on traite la saisonalité avec decompose soit avec un SARIMA
- Que veut dire "oublier une tendance avec différanciation" p.48 ?
- Est-ce que un modèle créé à partir de la méthode de Box-Jenkins est très différant d'un modèle obtenu par auto.arima (avec espace de rechereche large) ? cf. p.48
- Autres méthodes pour traiter les ruptures de tendance / variance ?

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

# Notes

- Ajouter label et titre dasn checkres
- Liens pour traiter l'hétéroscédasticité :
  - En python : https://python.plainenglish.io/heteroscedasticity-analysis-in-time-series-data-fee51503cc0e
  - En R : https://stats.stackexchange.com/questions/56538/how-to-test-heteroskedasticity-of-a-time-series-in-r
- Penser à explqiuer la significativité des paramètre => penser à être complet
- check polyfit
