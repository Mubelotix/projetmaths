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

./program < gauss_exemple_data.txt > Gauss_exemple_res.txt



simple précision vs double précision 
suite binaire
mantisse est une suite de m1 m2 jusqu'à m23
fl(x) = X
X = + ou - m*2pow(evrai)
m est compris entre 1 et 2 (c'est la normalisation)
m est la somme de i = 0 à 23 de mi/2powi
m0 = 1 donc on ne le code pas (bit caché)

l'exposant codé est la somme de i=0 à 7 de ei*powi
on a un biais pour passer des positifs en négatifs on a 2pow8 nombres donc on veut 2pow7 négatifs 127 négatifs 
le vrai exposant est l'exposant codé moins le biais

montrer comment on obtient m1, puis m2...
on prend la partie entière, on multiplie par 2, on prend la partie entière... 
quand on a une partie entière (ex 1.6) on soustrait mi donc si m4 alors -> 0.6
montrer le cycle
développement binaire infini
périodique
