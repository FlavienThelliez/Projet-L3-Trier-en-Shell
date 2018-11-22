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

triSelection(){ #triselection chaine nbElement chaineTri
    local chaine=$1
    local enCours=1
    local plusPetit
    local j=1
    local e1
    local e2
    local bool
    while [ $enCours -lt $2 ]
    do 
        plusPetit=$enCours
        echo "enCours au debut du while = $enCours"
	j=$enCours
	while [ $j -lt $2 ]
	do
	    echo "j au debut du while = $j"
            e1=`getIndiceI $chaine $j`
            e2=`getIndiceI $chaine $plusPetit`
	    echo "e1 = tab[$j] = $e1"
	    echo "e2 = tab[$plusPetit] = $e2"
	    bool=compare e1 e2 $3
	    if [ $bool -eq -1 ]
	    then 
		echo "e1 < e2"
		plusPetit=$j
    	    fi
	    echo "plusPetit = $plusPetit à la fin de la boucle"
	    j=$((j+1))
	done
	chaine=`swap $chaine $enCours $plusPetit`
	echo "chaine = $chaine"
	enCours=$((enCours+1))
    done	
    echo $chaine
}

compare (){ #e1 #e2 #chaineTri
    local triActuel=`echo $3 | cut -c1`
    #Pour chaque cas, on va faire la bonne comparaison en question 
    #si e1 > e2 faire echo 1
    #si e2 > e1 faire echo -1
    #si e1 = e2 
    #    si chaineTri moins son premier caractere = ""
    #        alors on retourne 0
    #    sinon 
    #        on relance compare avec e1 e2 et chaineTri moins son premier caractere
    #(pour les découpes de chaineTri, on fait `echo chaineTri | cut -c2-`
    #ca renvoie la chaine de tri sans son premier caractere)


    #cas si triactuel = n

    #cas si triactuel = s


    #cas si triactuel = m


    #cas si triactuel = l


    #cas si triactuel = e


    #cas si triactuel = t


    #cas si triactuel = p


    #cas si triactuel = g

}


init=$1
res=`creeTab $init`
chaine=`extraitChaine $res`
nbElem=`extraitNbElement $res`
echo $chaine
chaine=`swap $chaine 2 5`
echo $chaine
triSelection $chaine $nbElem


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