# time-series
Study of a time series and implementation of SARIMA-type models.

# Idées
- Ajouter les moyennes journalières en variable exogènes
# Modèles

1. Decompose
2. SARIMA
3. Log + SARIMA
4. Box-Cox + SARIMA => procédure choix du lambda (idem en R et Python = -0.7)

Est ce qu'il y une tendance linéaire/quadratique d ela série ?
Pourquoi p et q ?
Pourquoi P et Q ? Est ce que une diff + acf/pafc donnent  ?

Rupture variance ? Tendance ?

Si d=3 dans un SARIMA alors la tendance d'ordre 2 est éliminée ?
Si D=2 dans un SARIMA alors quoi ? Elimine tendance quadratique et la périodicité ??
Est ce que reg lin = diff ?
Est ce que reg lin = diff ?

=> cf notebook script_m

Nb. cv = 10

Tester la meilleur taille de trainset

# Tester diff

# Tester ar ma

# 
