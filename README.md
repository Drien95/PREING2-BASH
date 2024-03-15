**Syracus**

Ce script permet de générer des graphes représentant l'évolution de différents paramètres d'un système dynamique en fonction de deux bornes.

Un dossier **“Graphes”** va se créer dans lequel nous stockerons ces derniers ainsi qu’un fichier .txt **“synthese-min-max.txt”** ou seront mis les valeurs maximum/minimum de chaque paramètre altitude maximum, durée de vol et durée de vol en altitude.


Le script utilise le compilateur **gcc**.

Les graphes sont générés au format **PNG**.



## Installation

Téléchargez le script **syracus.sh**

Rendez le script exécutable :

`chmod u+x syracus.sh`
## Deployment

Pour _exécuter le script_, tapez la commande suivante :

`./syracus.sh $1 $2`

où :

__$1__ est la borne inférieure de l'intervalle

__$2__ est la borne supérieure de l'intervalle
Exemple

`./syracus.sh 100 500`

Cet exemple génère des graphes pour l'intervalle [100, 500].


## Authors

- [@Drien95](https://github.com/Drien95)

