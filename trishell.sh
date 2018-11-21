#!/bin/bash
# /mnt/c/Users/christopher/desktop/projetShell/

#Fonction dont on dispose dans ce projet pur l'instant

#creeTab() qui prend en argument un repertoire et qui retourne une chaine
#contenant le tableau et le nombre d'element de ce tableau séparé par un ;


#extraitChaine() qui prend en argument une chaine issu de creeTab et qui renvoie le 
#tableau associé

#extraitNbElement() qui prend en argument une chaine issu de creeTab et qui renvoie le 
#nbElement associé

#getIndiceI() qui prend en argument une chaine S et indice I et qui retourne l'element 
#à l'indice I du tableau S /!\ les indices vont de 1 à nbElement du tableau

#parcoursTab() qui prend en argument une chaine S et un nombre d'element nbElem et qui
#affiche tous les elements de S

#swap() qui prend en argument une chaine S et deux indice I1 et I2, cette fonction
#retourne une chaine similaire à S mais avec I1 et I2 inversé

#identifieRep() qui prend en argument un tableau S (le tableau donné par creeTab) et
#qui renvoie une chaine avec le meme fonctionnement que celle renvoyé par creeTab cad
#un tableau et son nombre d'element séparé par un ;


creeTab(){ #creeTab repertoire 
    local rep=$1
    local chaine=""
    local nbElem=0
    local listeFichier=`find $rep -maxdepth 1 | cut -c3-|grep -v '^$'`
    for fichier in $listeFichier
    do
	chaine="$chaine#$fichier"
	nbElem=$((nbElem+1))
    done
    chaine="$chaine#"
    echo "$chaine;$nbElem"
}

getIndiceI(){ #getIndiceI chaine indice
    local indice=$2
    indice=$((indice+1))
    echo $1 | cut -d# -f$indice
}

parcoursTab(){ #parcoursTab chaine tailleChaine
    local indice=1
    local element=""
    while [ $indice -le $2 ]
    do
        element=`getIndiceI $1 $indice`
	echo $element
        indice=$((indice+1))
    done
}

swap(){ #swap chaine ind1 ind2 (tailleTab potentiellement à voir)
    local element1=`getIndiceI $1 $2`
    local element2=`getIndiceI $1 $3`
    local chaine=`echo $chaine | sed "s/#$element1#/###/" | sed "s/#$element2#/#$element1#/" | sed "s/###/#$element2#/"`
    echo $chaine
}

extraitChaine(){
    echo $1 | cut -d";" -f1
}

extraitNbElement(){
    echo $1 | cut -d";" -f2
}

identifieRep(){
    local reps=""
    local fichiers=`parcoursTab $1 $2`
    local nb=0
    for element in $fichiers
    do 
	if [ -d $element ]
	then 
	    nb=$((nb+1))
	    reps="$reps#$element"
	fi
    done
    reps="$reps#;$nb"
    echo $reps    
}

init=$1
res=`creeTab $init`
chaine=`extraitChaine $res`
nbElem=`extraitNbElement $res`
res=`identifieRep $chaine $nbElem`
reps=`extraitChaine $res`
nbReps=`extraitNbElement $res`
parcoursTab $reps $nbReps
