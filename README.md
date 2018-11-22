# Projet-L3-Trier-en-Shell
Projet L3, à finir pour le 4 Décembre 2018.
Pouvant etre utile:

Dans le fichier trishell.sh : 

J'ai crée des fonctions qui permettent de creer un tableau de fichier en passant un repertoire en paramètre

J'ai une fonction swap fonctionnel qui prend un tableau (qui est juste une chaine traité comme) et deux indice i1 et i2

J'ai une derniere fonction qui quand à elle prend le tableau (toujours la chaine) et qui crée un 2eme tableau contenant les repertoires de ce premier tableau

On a donc toute la partie tableau de crée pour la partie tri 

##UPDATE le lendemain 22/11/2018

J'ai fait le tri par selection du minimum (c'est peut etre pas le tri final mais il marche)
Il prend juste un tableau et un nombre d'element

J'ai démarré la fonction compare mais c'est dans cette fonction qu'on va gerer tous les cas de tri (chaine nsl etc...)
c'est une fonction récursive qui va retourner 1, -1, 0 en fonction de si e1 est respectivement superieur, inferieur ou égale à e2
Elle ne s'appelera recursivement que lorsque la comparaison actuel est égale à 0, elle se re appelera avec la chaine de tri moins son premiere element

exemple :
compare "chaine" "chaine" nl

on compare chaine et chaine par leur nom
c'est égale donc on fait

compare "chaine" "chaine" l
si on obtient un autre resultat on le renvoie
sinon on renvoie 0 car l est la derniere lettre

PS : Me faire des issues si il te faut des fonctions en rapport avec l'aspect tableau

