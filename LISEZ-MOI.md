# Implémentation du pivot de Gauss en Pascal sur des nombres rationnels

Ce programme peut être utilisé pour la résolution de systèmes linéaires en le représentant sous la forme `AX = B` où `A` est une matrice carrée et `B` est une matrice colonne correspondant au second membre du système.

Le projet est accessible sur [GitHub](https://github.com/Mubelotix/projetmaths).

## Organisation du code

Le code est divisé en quatre fichiers :

```
projetmaths/
├─ io.pas               (gère l'entrée/sortie)
├─ main.pas             (point d'entrée du programme)
├─ matrix.pas           (gère la logique des matrices)
├─ num_rat.pas          (implémentation avec des nombres rationnels)
├─ num_fp.pas           (implémentation avec des nombres flottants)
└─ num.pas              (lien symbolique vers l'un des deux fichiers précédents)
```

Le coeur du programme réside dans `matrix.pas`. A la fin de ce fichier se trouve la fonction d'application de la méthode de Gauss sur des matrices.

## Machines testées

Le programme a été testé avec succès sur les machines suivantes :

- Machine de l'INSA
    - Processeur: Intel Core i7-9700
    - OS: Ubuntu 22.04 (Linux 5.15.0-53-generic)
    - Compilateur: FPC 3.2.2
    - IDE: VsCodium 1.73.1 + FPC 3.2.2

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

### Sortie

La sortie suit le même format que l'entrée.
Le programme retourne les deux matrices `A` et `B` après application de la méthode de Gauss.
Nous pouvons donc y retrouver un second membre ainsi que la solution.
Vous noterez que la matrice `A` est maintenant une matrice triangulaire supérieure. Ainsi, tous les coefficients de `A` en dessous de la diagonale sont nuls.

Si vous ne spécifiez pas de redirection de sortie, le programme affichera des informations concernant les calculs effectués au cours de l'application de la méthode de Gauss.
Ceci peut être utile pour comprendre le fonctionnement du programme étape par étape.

### Nomenclature

Il est conseillé de suffixer le fichier d'entrée par `_entree.txt` et celui de sortie par `_sortie.txt`.

Vous trouverez un fichier d'entrée et de sortie pour chacune de nos trois applications ainsi que pour notre exemple :
- `gauss_exemple_entree.txt` et `gauss_exemple_sortie.txt`
- `application_chimie_entree.txt` et `application_chimie_sortie.txt`
- `application_economie_entree.txt` et `application_economie_sortie.txt`
- `application_physique_entree.txt` et `application_physique_sortie.txt`

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

## Nombres flottants ou rationnels ?

Ce programme est capable de traiter des nombres rationnels ainsi que des nombres flottants.

A cette fin, un objet `Number` est défini et offre une interface commune pour les deux types de nombres, de telle manière à faire abstraction des détails de représentation dans l'algorithme de résolution.

Une implémentation de `Number` utilisant des nombres flottants en double précision se trouve dans le fichier `num_fp.pas`.
Une implémentation de `Number` utilisant des nombres rationnels se trouve dans le fichier `num_rat.pas`.
Un lien symbolique `num.pas` pointe vers l'une des deux implémentations.
La sélection de l'implémentation à utiliser se fait donc en modifiant le lien symbolique avant la compilation.

Par défaut, les nombres rationnels sont utilisés.

Voici la commande pour utiliser les nombres flottants:

```sh
rm num.pas && ln -s num_fp.pas num.pas
```

Et voici la commande pour utiliser les nombres rationnels:

```sh
rm num.pas && ln -s num_rat.pas num.pas
```

Il est **nécessaire** de recompiler le programme après avoir modifié le lien symbolique.

Le format d'entrée des données est exactement le même pour les deux implémentations. En entrée, les nombres doivent être écrits sous forme rationnelle. Ainsi, `0.5` n'est pas supporté et doit être écrit `1/2`. Si les nombres flottants sont utilisés, ils seront directement convertis après lecture.

Le format de sortie des données est globalement le même, mais ici les nombres flottants sont écrits avec un point. Ainsi, `1/2` sera écrit `0.5` si les nombres flottants sont utilisés et `1/2` si les nombres rationnels sont utilisés.

L'intérêt de l'utilisation d'une implémentation ou d'une autre est traité dans le rapport. Vous remarquerez que pour l'application d'économie, les nombres flottants ont été utilisés en raison du risque de débordement causé par les grands nombres utilisés.
