# Implémentation du pivot de Gauss en Pascal sur des nombres rationnels

Ce programme peut être utilisé pour la résolution de systèmes linéaires de la forme `AX = B` où `A` est une matrice carrée et `B` est une matrice colonne.

## Organisation du code

Le code est divisé en quatre fichiers :

```
projetmaths/
├─ fraction.pas         (gère la logique des nombres rationnels)
├─ io.pas               (gère l'entrée/sortie)
├─ main.pas             (point d'entrée du programme)
└─ matrix.pas           (gère la logique des matrices)
```

Le coeur du programme réside dans `matrix.pas`. A la fin de ce fichier se trouve la fonction d'application de la méthode de Gauss sur des matrices.

## Machines testées

Le programme a été testé avec succès sur les machines suivantes :

- Machine de l'INSA
    - Processeur: Intel
    - OS: Ubuntu
    - Compilateur: FPC
    - IDE: VsCodium + FPC

- Machine personnelle
    - Processeur: Intel Core i7-6700HQ
    - OS: Ubuntu 22.04 (Linux 5.15.0-53-generic)
    - Compilateur: FPC 3.2.2
    - IDE: VsCode 1.73.1 + FPC 3.2.2

## Entrée/Sortie et Nomenclature

Le programme lit les données depuis l'entrée standard et écrit les résultats sur la sortie standard.
Plutôt que de rentrer les données à la main, il est recommandé d'utiliser des fichiers de redirection.

### Entrée

L'entrée permet de définir la matrice `A` et la matrice `B` du système linéaire `AX = B`.
Pour rappel, `A` est une matrice carrée et `B` est une matrice colonne. Leurs tailles correspondent.
Notons `n` la taille de `A` et `B`.

L'entrée est composée de plusieurs lignes:
- La première ligne contient l'entier `n`, taille de `A` et `B`.
- Les `n` lignes suivantes contienent chacune `n` nombres rationnels séparés par des espaces. Ces nombres sont les coefficients de la matrice `A`.
- Les `n` lignes suivantes contiennent chacune un unique nombre rationnel. Ces nombres sont les coefficients de la matrice `B`.

Le numérateur et le dénominateur des nombres rationnels sont séparés par un slash `/`.
Les nombres peuvent être positifs ou négatifs.

Un exemple d'entrée se trouve dans le fichier `gauss_exemple_entree.txt`. Voici son contenu annoté:

```
3               (n = 3)
1   4/2   2     (ligne 1 de A) (le 4/2 est inutilement complexe pour l'exemple)
1    3   -2     (ligne 2 de A)
3    5    8     (ligne 3 de A)
2               (ligne 1 de B)
-1              (ligne 2 de B)
8               (ligne 3 de B)
```

Il est conseillé de suffixer le fichier d'entrée par `_entree.txt`.

### Sortie

La sortie suit le même format que l'entrée.
Le programme retourne les deux matrices `A` et `B` après application de la méthode de Gauss.
Nous pouvons donc y retrouver un second membre ainsi que la solution.
Vous noterez que la matrice `A` est maintenant une matrice triangulaire supérieure. Ainsi, tous les coefficients de `A` en dessous de la diagonale sont nuls.

Il est conseillé de suffixer le fichier de sortie par `_sortie.txt`.

## Exemple d'utilisation

Supposons que nous voulions résoudre le système linéaire suivant:

<img alt="Système linéaire" src="https://www.bibmath.net/dico/g/images/gausspivot1.png"/>

Après extraction des coefficients, nous formons les matrices `A` et `B`:

<img alt="A et B" src="https://latex.codecogs.com/svg.image?A&space;=&space;\begin{pmatrix}1&space;&&space;2&space;&&space;2&space;\\1&space;&&space;3&space;&&space;-2&space;\\3&space;&&space;5&space;&&space;8&space;\\\end{pmatrix}B&space;=&space;\begin{pmatrix}2&space;\\-1&space;\\8&space;\\\end{pmatrix}&space;"/>

La taille de ces matrices est `n = 3`.

Dans le fichier `gauss_exemple_entree.txt`, nous pouvons entrer les données suivantes:

```
3
1    2    2
1    3   -2
3    5    8
2
-1
8
```

Nous souhaitons recevoir les résultats dans le fichier `gauss_exemple_sortie.txt`.

Pour lancer le programme, nous pouvons utiliser les commandes suivantes:

```
fpc main.pas
./main < gauss_exemple_entree.txt > gauss_exemple_sortie.txt
```

En sortie, nous obtenons le fichier `gauss_exemple_sortie.txt` contenant (à quelques espaces près) :

```
3
1    2    2
0    1   -4
0    0   -2
2
-3
-1
```

Nous pouvons en déduire la solution du système linéaire initial après réécriture.

<img alt="Système linéaire final" src="https://www.bibmath.net/dico/g/images/gausspivot3.png">

## Bordel à trier

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
