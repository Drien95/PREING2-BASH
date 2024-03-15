#!/bin/bash

CC=gcc
EXE=syracus
SRC=syracus.c


#-----------------------------------FUNCTION---------------------------------#
# $1	fichier d'ou on extrait les données
# $2 	fichier qui recoit les données
# $3	U0
function recup_Un {
	head -n-3 $1 | tail -n+2 >> $2 && echo >> $2 
}
function recup_altitudemax {
	echo "$3 $(tail -n3 $1 | head -n1 | cut -d':' -f2)" >> $2
}
function recup_dureevol {
	echo "$3 $(tail -n2 $1 | head -n1 | cut -d':' -f2)" >> $2
}
function recup_dureealtitude {
	echo "$3 $(tail -n1 $1 | cut -d':' -f2)" >> $2
}
function max_min_altitudemax {
	echo "Altitude max de toutes les altitudes max de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | tail -1)" >> $2
	echo "Altitude min de toutes les altitudes max de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | head -1)" >> $2
}
function max_min_dureevol {
	echo "Durée de vol max de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | tail -1)" >> $2
	echo "Durée de vol min de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | head -1)" >> $2
}
function max_min_dureealtitude {
	echo "Durée d'altitude max de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | tail -1)" >> $2
	echo "Durée d'altitude min de tous les U0: $(sort -k2n $1 | cut -d' ' -f2 | head -1)" >> $2
}
#---------------------------------END-FUNCTION-------------------------------#


#-------------------------------------MAIN-----------------------------------#
#Première vérification
#Si le nombre d argument nest pas bon
if [ "$#" -ne 2 ]
then
	echo "Le nombre d'argument doit être de 3"
	exit
fi

#On effectue une comparaison d anciennete entre l executable et le .c en question
if [ "$SRC" -nt "$EXE" ]
then
	echo "Recompilation de l'executable $EXE" 
	$CC -o $EXE $SRC
fi

#Creation d un fichier temporaire
mkdir -p Data

#Boucle qui prend comme paramètre les bornes inf et sup = [$1;$2]
for (( i=$1; i<=$2; i++))
do
	#execute le programme C ./exe U0 fileU0.dat
	./$EXE $i Data/file$i.dat

	# on recupere les données dans des fichiers temporaires à l'aide de nos fonctions

	#récupération de toutes les suites en fontion de n
	recup_Un Data/file$i.dat Data/toutes_suites.dat

	#récupération de toutes les altitudes max
	recup_altitudemax Data/file$i.dat Data/toutes_altitude_max.dat $i

	#récupération de toutes les durées de vols
	recup_dureevol Data/file$i.dat Data/toutes_duree_vol.dat $i

	#récupération de toutes les durées d altitudes
	recup_dureealtitude Data/file$i.dat Data/toutes_duree_altitude.dat $i

	#On supprime les fichiers dès lors qu'ils sont créés
	rm Data/file$i.dat
done

mkdir -p Graphes

#Analyse avec gnuplot
gnuplot -persist <<-EOFMarker
	set terminal jpeg
	set output "Graphes/Graphe_toutes_suites[$1;$2].jpeg"
	set title "Un en fonction de n pour U0 dans [$1;$2]"
	set xlabel "n"
	set ylabel "Un"
	plot "Data/toutes_suites.dat" w l title "vols"
	reset
	set terminal jpeg
	set output "Graphes/Graphe_duree_vol[$1;$2].jpeg"
	set title "Durée de vol en fonction du U0 dans [$1;$2]"
	set xlabel "U0"
	set ylabel "Nombre d'occurences"
	plot "Data/toutes_duree_vol.dat" w l title "durée vol"
	reset
	set terminal jpeg
	set output "Graphes/Graphe_altitude_max[$1;$2].jpeg"
	set title "Altitute maximum atteinte en fonction de U0 dans [$1;$2]"
	set xlabel "U0"
	set ylabel "Altitude Maximum"
	plot "Data/toutes_altitude_max.dat" w l title "altitude"
	reset
	set terminal jpeg
	set output "Graphes/Graphe_duree_altitude[$1;$2].jpeg"
	set title "Durée de vol en altitude en fonction de U0 dans [$1;$2]"
	set xlabel "U0"
	set ylabel "Nombre d'occurence"
	plot "Data/toutes_duree_altitude.dat" w l title "durée altitude"
	reset
EOFMarker
#----------------------------BONUS-----------------------------#
# bonus faire la synthese min max moyenne

max_min_altitudemax Data/toutes_altitude_max.dat synthese-min-max.txt

max_min_dureevol Data/toutes_duree_vol.dat synthese-min-max.txt

max_min_dureealtitude Data/toutes_duree_altitude.dat synthese-min-max.txt

#Dans le cas ou le programme plante
if [ "$?" == "EXIT_FAILURE" ]
then
	echo "Erreur d'argument"
	exit
fi

#Suppression de notre fichier temporaire
rm -rf Data
