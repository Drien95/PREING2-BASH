Syracus

Ce script permet de générer des graphes représentant l'évolution de différents paramètres d'un système dynamique en fonction de deux bornes.

Installation

Téléchargez le script syracus.sh.
Rendez le script exécutable :
chmod u+x syracus.sh
Utilisation

Pour exécuter le script, tapez la commande suivante :

./syracus.sh $1 $2
où :

$1 est la borne inférieure de l'intervalle
$2 est la borne supérieure de l'intervalle
Exemple

./syracus.sh 100 500
Cet exemple génère des graphes pour l'intervalle [100, 500].

Fichiers générés

Le script génère les fichiers suivants :

Un dossier Data contenant les fichiers temporaires utilisés pour générer les graphes. Ce dossier est supprimé à la fin du script.
Un dossier Graphes contenant les graphes générés.
Un fichier synthese-min-max.txt contenant les valeurs minimum et maximum de chaque paramètre : altitude maximum, durée de vol et durée de vol en altitude.
Remarques

Le script utilise le compilateur gcc.
Les graphes sont générés au format PNG.
Licence

Ce script est sous licence GPLv3.

Contributeurs

[Votre nom]
Liens

[Lien vers le site web du projet] (si applicable)
[Lien vers le dépôt Git du projet] (si applicable)
Aide

Si vous rencontrez des problèmes avec le script, veuillez consulter la documentation ou contacter les contributeurs.

Cordialement,

[Votre nom]
