#!/bin/bash




while [ $# -gt 1 ]
do
    case $1 in
	-R)
	    echo "Tri des sous-répertoire"
	    ;;
	-d)
	    echo "Tri dans l'ordre décroissant"
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


function tri_n(){
    
}
function tri_s(){
    
}
function tri_m(){
    
}
function tri_l(){
    
}
function tri_e(){
    
}
function tri_t(){
    
}
function tri_p(){
    
}
function tri_g(){
    
}
