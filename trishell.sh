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
    local listeFichier=`find $rep -maxdepth 1 | grep -v "^$rep$" | grep -v '^$'`
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
    element1=`echo $element1 | sed "s/\//=/g"`
    element2=`echo $element2 | sed "s/\//=/g"`
    local chaine=`echo $1 | sed "s/\//=/g"`
    chaine=`echo $chaine | sed "s/#$element1#/###/" | sed "s/#$element2#/#$element1#/" | sed "s/###/#$element2#/"`
    chaine=`echo $chaine | sed "s/=/\//g"`
    echo $chaine
}

extraitChaine(){
    echo `echo $1 | cut -d";" -f1`
}

extraitNbElement(){
    echo `echo $1 | cut -d";" -f2`
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

triSelection(){ #triselection chaine nbElement chaineTri reverse
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
	j=$enCours
	while [ $j -le $2 ]
	do
            e1=`getIndiceI $chaine $j`
            e2=`getIndiceI $chaine $plusPetit`
	    bool=`compare $e1 $e2 $3 $4`
	    if [ $bool -eq -1 ]
	    then 
		plusPetit=$j
    	    fi
	    j=$((j+1))
	done
	chaine=`swap $chaine $enCours $plusPetit`
	enCours=$((enCours+1))
    done	
    echo $chaine
}

getType(){ #chaine
    local res
    if [ -d $1 ]
    then
        res=0
    fi
    if [ -f $1 ]
    then
        res=1
    fi
    if [ -L $1 ]
    then
        res=2
    fi
    if [ -b $1 ]
    then
        res=3
    fi
    if [ -c $1 ]
    then
        res=4
    fi
    if [ -p $1 ]
    then
        res=5
    fi
    if [ -S $1 ]
    then
        res=6
    fi
    echo $res
}

compare (){ #e1 #e2 #chaineTri reverse
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
    local tmp
    local res
    echo $res
    local e1
    local e2
    case $triActuel in 
        "n")if [ $1 \< $2 ]
	    then
                res=-1
	    else 
                if [ $1 \> $2 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi		
	;;
	
        "s")e1=`stat -c "%s" $1 | cut -d" " -f1`
            e2=`stat -c "%s" $2 | cut -d" " -f1`
	    if [ $e1 -lt $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 -lt $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi	 
	;;
        
	"l")if [ -d $1 ]
	    then 
                e1=0
	    else 
	        e1=`wc -l $1 | cut -d" " -f1`
	    fi
	    if [ -d $2 ]
	    then
		e2=0
	    else 
                e2=`wc -l $2 | cut -d" " -f1`
	    fi	
	    if [ $e1 -lt $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 -lt $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi
	;;
        
	"m")e1=`stat -c "%y" $1 | cut -d" " -f1`
            e2=`stat -c "%y" $2 | cut -d" " -f1`
	    if [ $e1 \< $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 \< $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi
	;;
        
	"e")e1=`echo $1 | sed "s/./=/" |grep -Eo "\..+$"`
	    e2=`echo $2 | sed "s/./=/" |grep -Eo "\..+$"`
	    if [ -z $e1 ]
	    then
		if [ -z $e2 ]
		then 
		    tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
		        res=`compare $1 $2 $tmp $4`
		    fi	 
		else
		    res=-1
		fi
	    else 
		if [ -z $e2 ]
		then
		    res=1
		else 
	    	    if [ $e1 \< $e2 ]
	    	    then
			res=-1
	            else 
                	if [ $e2 \< $e1 ]
			then 
		    	    res=1
	        	else 
	            	    tmp=`echo $3 | cut -c2-`
                    	    if [ -z $tmp ]
		    	    then
		        	res=0
		    	    else
				res=`compare $1 $2 $tmp $4`
		            fi	
		        fi
	    	    fi
	        fi
	    fi
	;;
        
	"t")e1=`getType $1`
            e2=`getType $2`
	    if [ $e1 -lt $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 -lt $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi 
	;;
        
	"p")e1=`stat -c "%U" $1 | cut -d" " -f1`
            e2=`stat -c "%U" $2 | cut -d" " -f1`
	    if [ $e1 \< $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 \< $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi
	;;
        
	"g")e1=`stat -c "%G" $1 | cut -d" " -f1`
            e2=`stat -c "%G" $2 | cut -d" " -f1`
	    if [ $e1 \< $e2  ]
	    then
                res=-1
	    else 
                if [ $e2 \< $e1 ]
		then 
		    res=1
	        else 
	            tmp=`echo $3 | cut -c2-`
                    if [ -z $tmp ]
		    then
		        res=0
		    else
			res=`compare $1 $2 $tmp $4`
		    fi	
		fi
	    fi
	;; 
    esac
    res=$(($4*$res))
    echo $res
}

sontValides(){ #option
    if [ -z $1 ]
    then 
        res=1
    else 
        local res=1
        local option=`echo $1 | cut -c1`
        case $option in 
    	    "n")res=1
	    ;;
	    "s")res=1
	    ;;
	    "m")res=1
	    ;;
            "l")res=1
	    ;;
	    "e")res=1
	    ;;
	    "t")res=1
	    ;;
            "p")res=1
 	    ;;
	    "g")res=1
	    ;;
            *)res=0
        esac
        local reste=`echo $1 | cut -c2-`
        if [ -z $reste  ]
        then
	    res=$res
        else
            res=`sontValides $reste`
        fi
    fi
    echo $res
}

arg_r=0
arg_d=0
arg_opt=0
while [ $# -gt 1 ]
do
    parametre=`echo -$1 | cut -c3-`
    if [ -z $parametre ]
    then 
        echo "Utilisez ce format : ./trishell.sh [-R] [-d] [-nsmletpg] repertoire"
	exit 1
    else 
        case $parametre in
            "R") arg_r=1
            ;;
            "d") arg_d=1
	    ;;
            *) if [ $arg_opt -eq 0 ]
	       then
	           arg_opt=1
		   option=$parametre
	       else 
		   echo "Trop d'options ont été donné concernant les tris !"
		   exit 1
	       fi
	    ;;
        esac
    fi
    shift
done

test_option=`sontValides $option`

if [ $test_option -eq 0 ]
then
    echo "Les options de tris ne sont pas valides, pour rappel seul n s m l e t p g sont des options valides de tri"
    exit 1
else 
    depart=`creeTab $1` 
    chaine=`extraitChaine $depart`
    nbElem=`extraitNbElement $depart`		
    if [ $arg_r -eq 1 ]
    then  
	opt_R="-R"    
        recupRep=`identifieRep $chaine $nbElem`
	reps=`extraitChaine $recupRep`
	nbReps=`extraitNbElement $recupRep`
    else 
	opt_R=""    
	reps=""
	nbReps=0
    fi
    reverse=1
    if [ $arg_d -eq 1 ]
    then
	opt_d="-d"    
        reverse=-1
    else
	opt_d="" 
    fi
    if [ $arg_opt -eq 1 ]
    then
	opt_tri="-$option"
    else 
	opt_tri="-n"
	option="n"
    fi
    chaine=`triSelection $chaine $nbElem $option $reverse`
    parcoursTab $chaine $nbElem
    if [ -z $reps ]
    then 
        a=1
    else 
	liste_rep=`identifieRep $chaine $nbElem`
	reps=`extraitChaine $liste_rep`
	nbReps=`extraitNbElement $liste_rep`
    	listeRep=`parcoursTab $reps $nbReps`
        for repertoire in $listeRep
	do
            echo "Tri du sous repertoire $repertoire avec les options $opt_tri :"
	    $0 $opt_R $opt_d $opt_tri $repertoire
	done
    fi
fi
