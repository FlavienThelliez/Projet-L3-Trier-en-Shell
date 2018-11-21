#!/bin/bash

function tri_n(){
    echo "Tri par nom"
    find
}
function tri_s(){
    echo "Tri par taille"
}
function tri_m(){
    echo "Tri par date"
}
function tri_l(){
    echo "Tri par nb lignes"
}
function tri_e(){
    echo "Tri par extension"
}
function tri_t(){
    echo "Tri par type de fichier"
}
function tri_p(){
    echo "Tri par propriétaire"
}
function tri_g(){
    echo "Tri par groupe propriétaire"
}


arg_r=false
arg_d=false

while [ $# -gt 1 ]
do
    case $1 in
	-R)
	    echo "Tri des sous-répertoire"
	    arg_r=true 
	    ;;
	-d)
	    echo "Tri dans l'ordre décroissant"
	    arg_d=true
	    ;;
	-*)
	    echo "Autre option"
	    echo "ajouter de quoi gérer la chaine"
	    ;;
	*)
	    echo "Utilez ce format : ./trishell [-R] [-d] -[nsmletpg] rep"
	    exit 1
	    ;;
    esac
    shift
done

rep=$1
echo "Affichage du répertoire $rep"

