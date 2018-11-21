#!/bin/bash

function swap(){
    echo "Cette fonction marche pas"
    if [ $# -eq 2 ]
    then
	tmp=$2
	$2=$1
	$1=$tmp
    fi
}

function tri_selection(){
    #Parametre : une GROSSE CHAINE DE CARACTERE
    para=Fichier\/\/file2\/\/file3


    #Comment démonter la chaine et comparer deux éléments ?
    echo `expr "$para" : '\([a-zA-z]*\)'`
    echo "TEST"
    
}

x="foo"
y="bar"

z=$x
x=$y
y=$z
#echo $x

tri_selection
