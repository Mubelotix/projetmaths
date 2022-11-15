# specs de toutes les machines testées
description machine
processeur
système d'exploitation nom version
compilateur nom version
environnement de programmation nom version

# Fichiers de données / de résultats

## Nomenclature des fichiers

Mettre ses résultats 
au lieu de rentrer au clavier la matrice et le second membre on met ça dans un fichier
on a donc la dimension la matrice et après le second membre

en sortie on a la matrice le second membre et notre solution

Gauss_LU_exemple_data.txt   ENTREE contient Dimensions, les éléments de la matrice et le second membre
Gauss_LU_exemple_res.txt    SORTIE contient a, b et x

## Contenu du fichier

Dimensions, les éléments de la matrice et le second membre

./program < gauss_lu_exemple_data.txt > Gauss_LU_exemple_res.txt
