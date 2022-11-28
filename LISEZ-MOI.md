# Implémentation du pivot de Gauss en Pascal sur des nombres rationnels

Ce programme peut être utilisé pour la résolution de systèmes linéaires en le représentant sous la forme `AX = B` où `A` est une matrice carrée et `B` est une matrice colonne correspondant au second membre du système.

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

Si vous ne spécifiez pas de redirection de sortie, le programme affichera des informations concernant les calculs effectués au cours de l'application de la méthode de Gauss.
Ceci peut être utile pour comprendre le fonctionnement du programme étape par étape.

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

```sh
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

Afin de mieux comprendre le déroulement des calculs, nous pouvons désactiver la redirection de sortie.
Le programme affichera alors les étapes de la méthode de Gauss dans la console.
Ainsi, après lancement de la commande suivante:

```sh
./main < gauss_exemple_entree.txt
```

La sortie ressemble à ceci:

```
Step 0 :
┌      ┐
│  2   │
│ -1   │
│  8   │
└      ┘
┌              ┐
│  1   2   2   │
│  1   3  -2   │  L2 ← L2 - 1 * L1
│  3   5   8   │  L3 ← L3 - 3 * L1
└              ┘
Step 1 :
┌      ┐
│  2   │
│ -3   │
│  2   │
└      ┘
┌              ┐
│  1   2   2   │
│  0   1  -4   │
│  0  -1   2   │  L3 ← L3 - -1 * L2
└              ┘
Terminé!
┌      ┐
│  2   │
│ -3   │
│ -1   │
└      ┘
┌              ┐
│  1   2   2   │
│  0   1  -4   │
│  0   0  -2   │
└              ┘
```

A chaque étape, le programme affiche la matrice `B` puis `A`, accompangée des opérations qui seront effectuées sur les lignes pour passer à l'étape suivante.

## Nombres flottants et norme IEEE 754

Cette norme offre deux représentations pour les nombres flottants suivant la précision souhaitée. La simple précision utilise 32 bits tandis que la double précision en utilise 64. Afin de garder les explications simples, nous nous limiterons à la simple précision, mais les mêmes principes pourraient être appliqués aux nombres flottants en double précision.

L'allocation des bits est la suivante:

<img src="visuals/bit_allocation.svg">

La lecture et l'interprétation des trois parties est la première étape pour décoder un nombre flottant.

### Signe

<!-- 
\left\{\begin{matrix}
signe = -1 \; \; \; \; \; \; \; \; \; si \; s = 1 \\
signe = +1 \; \; \; \; \; \; \; \; \; si \; s = 0 
\end{matrix}\right.
-->

Le bit de signe est le premier bit de la représentation. Il est égal à 0 pour les nombres positifs et 1 pour les nombres négatifs.

<img src="https://latex.codecogs.com/svg.image?\left\{\begin{matrix}signe&space;=&space;-1&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;si&space;\;&space;s&space;=&space;1&space;\\signe&space;=&space;&plus;1&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;\;&space;si&space;\;&space;s&space;=&space;0&space;\end{matrix}\right.">

### Exposant

L'exposant codé est une valeur entière classique sur huit bits.

<!-- exposant_{code} = \sum_{0}^{7}{ e_{i}*2^{7-i}} -->

<img src="https://latex.codecogs.com/svg.image?exposant_{code}&space;=&space;\sum_{0}^{7}{&space;e_{i}*2^{7-i}}">

Comme l'exposant réel a parfois besoin d'être négatif et que l'exposant codé ne permet de représenter que les nombres de 0 à 255, il est nécessaire de décaler l'exposant codé d'un biais pour obtenir la valeur réelle de l'exposant. En simple précision, le biais est de 127. Ainsi, l'exposant a une valeur réelle comprise entre -127 et 128.

<!-- exposant = exposant_{code} - 127 -->

<img src="https://latex.codecogs.com/svg.image?exposant&space;=&space;exposant_{code}&space;-&space;127">

### Mantisse

La mantisse codée est une suite binaire allant de m0 à m23. Le premier élément m0 n'est pas codé, car il vaut toujours 1. On l'appelle le bit caché. La valeur réelle de la mantisse est définie de la sorte :

<!-- mantisse = \sum_{0}^{23}\frac{m_{i}}{2^{i}} -->

<img src="https://latex.codecogs.com/svg.image?mantisse&space;=&space;\sum_{0}^{23}\frac{m_{i}}{2^{i}}">

Ainsi, la valeur de la mantisse est comprise entre 1 et 2. Elle est dite normalisée.

### Valeur du nombre

Ayant défini les valeurs des trois parties, il est possible de calculer la valeur du nombre flottant.

<!-- X = signe * mantisse * 2^{exposant} -->

<img src="https://latex.codecogs.com/svg.image?X&space;=&space;signe&space;*&space;mantisse&space;*&space;2^{exposant}">

Vous remarquerez la proximité entre le principe de la virgule flottante et l'écriture scientifique des nombres. La principale différence étant la base utilisée.

montrer comment on obtient m1, puis m2...
on prend la partie entière, on multiplie par 2, on prend la partie entière... 
quand on a une partie entière (ex 1.6) on soustrait mi donc si m4 alors -> 0.6
montrer le cycle
développement binaire infini
périodique
