# Ceci est la version en markdown de la partie informatique du rapport.

## Nombres flottants et norme IEEE 754

Cette norme offre deux représentations pour les nombres flottants suivant la précision souhaitée. La simple précision utilise 32 bits tandis que la double précision en utilise 64. Afin de garder les explications simples, nous nous limiterons à la simple précision, mais les mêmes principes pourraient être appliqués aux nombres flottants en double précision.

L'allocation des bits est la suivante:

<img width="100%" src="visuals/bit_allocation.svg">

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

## Exemples

### Exemple d'un nombre codé sans erreur

Nous allons commencer par fixer une représentation flottante au hasard, puis calculer sa valeur. Nous pourrons déduire que la valeur trouvée possède une représentation flottante exacte.

<img width="100%" src="visuals/exemple_exact.svg">

<!-- exposant = exposant_{code} - 127 = 128 - 127 = 1 -->

<img src="https://latex.codecogs.com/svg.image?exposant&space;=&space;exposant_{code}&space;-&space;127&space;=&space;128&space;-&space;127&space;=&space;1">

<!-- mantisse = 2^{0} + 2^{-2} + 2^{-5} = 1.28125 -->

<img src="https://latex.codecogs.com/svg.image?mantisse&space;=&space;2^{0}&space;&plus;&space;2^{-2}&space;&plus;&space;2^{-5}&space;=&space;1.28125">

<!-- X = signe * mantisse * 2^{exposant} = 1 * 1.28125 * 2^{1} = 2.5625 -->

<img src="https://latex.codecogs.com/svg.image?X&space;=&space;signe&space;*&space;mantisse&space;*&space;2^{exposant}&space;=&space;1&space;*&space;1.28125&space;*&space;2^{1}&space;=&space;2.5625">

Donc 2.5625 peut être représenté exactement en simple précision.

### Exemple d'un nombre codé avec erreur

Nous allons maintenant prendre un nombre décimal et tenter de trouver sa mantisse codée. Prenons 0,55. Une méthode simple pour trouver la mantisse est de réaliser successivement l'opération suivante sur le nombre :

- Multiplier le nombre par 2
- Mettre de côté le chiffre de la partie entière
- Si le nombre est supérieur à 1, y soustraire 1

Notez que si on tombe sur 0 par chance, alors on peut arrêter la répétition car tous les prochains chiffres seront des 0.

L'opération peut être répétée 24 fois au maximum (23 bits de mantisse + 1 bit caché). Après suppression du bit caché, nous obtenons alors la mantisse codée. Essayons d'appliquer cette méthode à 0,55.

<!-- 
\\
0.55 * 2 = 1.1 \\
1.1 \geqslant 1 \to {\color{Red} 1} \\
1.1 - 1 = 0.1 \\
\\
\left.\begin{matrix}
0.1 * 2 = 0.2 \\
0.2 \leqslant 1 \to {\color{Red} 0} \\
\\
0.2 * 2 = 0.4 \\
0.4 \leqslant 1 \to {\color{Red} 0} \\
\\
0.4 * 2 = 0.8 \\
0.8 \leqslant 1 \to {\color{Red} 0} \\
\\
0.8 * 2 = 1.6 \\
1.6 \geqslant 1 \to {\color{Red} 1} \\
1.6 - 1 = 0.6 \\
\end{matrix}\right\}{cycle} \\
\\
\\
0.6 * 2 = 1.2 \\
1.2 \geqslant 1 \to {\color{Red} 1} \\
1.2 - 1 = 0.2 \\
\\
\cdots 
-->

<img src="https://latex.codecogs.com/svg.image?\\0.55&space;*&space;2&space;=&space;1.1&space;\\1.1&space;\geqslant&space;1&space;\to&space;{\color{Red}&space;1}&space;\\1.1&space;-&space;1&space;=&space;0.1&space;\\\\\left.\begin{matrix}0.1&space;*&space;2&space;=&space;0.2&space;\\0.2&space;\leqslant&space;1&space;\to&space;{\color{Red}&space;0}&space;\\\\0.2&space;*&space;2&space;=&space;0.4&space;\\0.4&space;\leqslant&space;1&space;\to&space;{\color{Red}&space;0}&space;\\\\0.4&space;*&space;2&space;=&space;0.8&space;\\0.8&space;\leqslant&space;1&space;\to&space;{\color{Red}&space;0}&space;\\\\0.8&space;*&space;2&space;=&space;1.6&space;\\1.6&space;\geqslant&space;1&space;\to&space;{\color{Red}&space;1}&space;\\1.6&space;-&space;1&space;=&space;0.6&space;\\\end{matrix}\right\}{cycle}&space;\\\\\\0.6&space;*&space;2&space;=&space;1.2&space;\\1.2&space;\geqslant&space;1&space;\to&space;{\color{Red}&space;1}&space;\\1.2&space;-&space;1&space;=&space;0.2&space;\\\\\cdots&space;">

Les nombres en rouge ci-dessus sont les chiffres de la mantisse codée.

Au cours de la recherche de celle-ci, nous tombons sur une valeur qui a déjà été rencontrée précédemment. Si l'on continuait, on constaterait une répétition sur les prochains chiffres également. Nous rencontrons ici une boucle infinie, ce qui signifie que le développement binaire de 0,55 est infini, et que 0,55 a besoin d'une infinité de chiffres après la virgule pour être représenté. Comme nous ne pouvons stocker que les 23 premiers chiffres, il y aura donc forcément une erreur d'imprécision.

Voici le résultat codé :

<img width="100%" src="visuals/exemple_arrondi.svg">

Remarquez le motif périodique de longueur 4.

Nous pouvons aisément calculer la valeur à laquelle correspond ce nombre arrondi, en utilisant la méthode décrite dans la section précédente. Ensuite, nous pouvons faire la différence avec notre valeur de départ pour obtenir l'erreur d'imprécision.

Cherchons X le nombre réellement codé par le flottant ci-dessus.

<!-- X = 2^{-1}\times (2^{0} + 2^{-4} + 2^{-5} + 2^{-8} + 2^{-9} + 2^{-12} + 2^{-13} + 2^{-16} + 2^{-17} + 2^{-20} + 2^{-21}) -->
<img src="https://latex.codecogs.com/svg.image?X&space;=&space;2^{-1}\times&space;(2^{0}&space;&plus;&space;2^{-4}&space;&plus;&space;2^{-5}&space;&plus;&space;2^{-8}&space;&plus;&space;2^{-9}&space;&plus;&space;2^{-12}&space;&plus;&space;2^{-13}&space;&plus;&space;2^{-16}&space;&plus;&space;2^{-17}&space;&plus;&space;2^{-20}&space;&plus;&space;2^{-21})">

Nous pouvons donc calculer la valeur rationnelle exacte de X.
En prévision de la prochaine étape, nous allons multiplier le numérateur et dénominateur de X par 5.

<!-- X = \frac{2306867}{4194304} = \frac{2306867\times 5}{4194304\times 5} = \frac{11534335}{20971520} -->
<img src="https://latex.codecogs.com/svg.image?X&space;=&space;\frac{2306867}{4194304}&space;=&space;\frac{2306867\times&space;5}{4194304\times&space;5}&space;=&space;\frac{11534335}{20971520}">

Mettons la valeur originale x = 0.55 sous le même dénominateur.

<!-- x = 0.55 = \frac{0.55 \times  20971520}{20971520} = \frac{11534336}{20971520} -->
<img src="https://latex.codecogs.com/svg.image?x&space;=&space;0.55&space;=&space;\frac{0.55&space;\times&space;&space;20971520}{20971520}&space;=&space;\frac{11534336}{20971520}">

On a bien deux nombres différents.

<!-- X = \frac{11534335}{20971520} \neq  \frac{11534336}{20971520} = x -->
<img src="https://latex.codecogs.com/svg.image?X&space;=&space;\frac{11534335}{20971520}&space;\neq&space;&space;\frac{11534336}{20971520}&space;=&space;x">

Nous pouvons finalement calculer l'erreur d'imprécision.

<!-- x - X = \frac{11534336}{20971520} - \frac{11534335}{20971520} = \frac{1}{20971520} -->
<img src="https://latex.codecogs.com/svg.image?x&space;-&space;X&space;=&space;\frac{11534336}{20971520}&space;-&space;\frac{11534335}{20971520}&space;=&space;\frac{1}{20971520}">

On remarque que même pour de la simple précision, l'erreur reste très faible. Cependant, comme elle est relative, il faut s'attendre à ce qu'elle soit bien plus élevée pour des nombres plus grands. Par exemple, dans mon expérience, des valeurs entières sur 64 bits ne peuvent être représentées même en double précision qu'avec un arrondi à plusieurs milliers près. Il est considéré comme imprudent d'essayer de stocker des nombres entiers supérieurs à 2^53 en double précision. En dessous de cette valeur, les arrondis ne dépassent jamais 1.
