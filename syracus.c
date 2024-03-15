#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void syracuse(int Un, FILE*); //prototype de la fonction de syracuse 

int main(int argc, char *argv[]) {
    
    if(argc !=3) exit(EXIT_FAILURE); // Si l'on a pas 3 arguments, on affiche une erreur 
    int Un = atoi(argv[1]); 
    
    FILE* fichier = fopen(argv[2], "w+");
    if (fichier == NULL) printf("error");
	//ouverture d'un fichier avec mode lecture/ecriture
    syracuse(Un, fichier); /* appel de la fonction avec comme paramètres le nb de départ et le fichier 
    dans lequel on va écrire les valeurs */
    fclose(fichier); //on ferme le fichier 
    return 0;
    
}

void syracuse(int Un, FILE* f) { 

  int altitudeMax = 0; // Altitude maximale
  int i = 0; // Temps de vol
  //int Un = 0; //Initialisation de l'altitude de départ
  int UCompteur = 0; // Pour compter le nombre d'etapes en altitude
  int IncrUCompteur = 1; // Pour stopper le compteur des que Un passe sous U0
  int UPremier = 0; //premier terme (=Un)
 
  fprintf(f, "n Un\n"); // marque chaque altitude en fonction de l'étape 
  altitudeMax = Un;
  UPremier = Un;
  fprintf(f,"%d %d\n", i, Un);
  i++;
    
  // Suite de syracuse 
  //Séparation cas pair et cas impair pour appliquer la suite 
  while (Un > 1) {
      
    if (Un % 2 == 0) { // Cas Un pair 
    
      Un = (Un / 2);
      fprintf(f,"%d %d\n", i, Un);
      i++;
    }
    else { // Cas Un impair
      Un = ((Un * 3) + 1);
      fprintf(f,"%d %d\n", i, Un);
      i++;
    }
    
    // Calcul de l'altitude maximale
    // L'altitude max de départ est Un (premier terme)
    if (altitudeMax < Un) { // si la variable est < à l'altitude actuelle
        altitudeMax = Un; // elle devient l'altitude actuelle donc max
    }
    
    // Calcul du temps de vol au dessus de l'altitude de départ
    // Upremier vaut l'altitude de départ
    //A chaque altitude, si elle est au dessus, on ajoute +1 à un compteur
    if (Un < UPremier) {
      IncrUCompteur = 0;
    }
    if (Un >= UPremier) {
      UCompteur += IncrUCompteur;
    }
   }
   fprintf(f,"Altitude max:%d\n", altitudeMax); // affiche l'altitude maximale
   fprintf(f,"Duree de vol:%d\n", i); // affiche la durée de vol
   fprintf(f,"Durée de l'altitude:%d\n", UCompteur); // affiche la durée d'altitude au dessus de l'altitude de depart 
}

  




