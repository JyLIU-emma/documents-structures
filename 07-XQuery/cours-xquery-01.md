# XQuery

## Introduction

`XQuery` ou `XML Query Language` est défini par le [W3C](https://www.w3.org/XML/Query/). C'est un langage de requêtes pour exploiter, extraire de l'information des documents XMLs. On peut dire que c'est un peu le `SQL` du XML.

C'est une extension de `XPath`, ainsi la syntaxe, les conceptions et les fonctions sont reprises.

`XQuery` est lié à `XSLT`, on peut s'en servir pour transformer des documents également. Néanmoins, il ne s'agit **pas** d'une syntaxe XML.

C'est un langage de programmation dit `fonctionnel`. Chaque expression évalue un résultat, le résultat est toujours le même donc il n'y a pas d'effet de bord. Les variables sont **immuables*, il n'est pas possible de modifier la valeur une fois assignée.

Il est également adapté pour mettre à jour des documents XMLs.

## Syntaxe

### Préambule

On peut évaluer directement le résultat d'une expression, ainsi `1 + 1`  donne bien `2`.

On peut construire des éléments en écrivant le XML, l'expression `XQuery` sera alors mise entre accolades `{}`. Dans l'exemple ci-dessous, on construit les éléments `resultats` et `resultat` manuellement. Ensuite, on assigne en valeur le retour de l'expression `XQuery` évalué par les accolades.

``` xquery
<resultats>
    <resultat>{1 + 1}</resultat>
    <resultat somme="{1 + 1}"/>
</resultats>

<resultats>
    <resultat>2</resultat>
    <resultat somme="2"/>
</resultats>
```

Les fonctions de la librairie standard peuvent être invoquées. Ne pas oublier les accolades.

``` xquery
<majuscule>{upper-case('hello world')}</majuscule>

<majuscule>HELLO WORLD</majuscule>
```

Parfois, on veut évaluer un nom d'élément dynamiquement. Il faut utiliser la construction `element {}{}`.  `element {"nom_balise"}{valeur}`

``` xquery
element {
    if((year-from-date(current-date()) mod 4) eq 0)
    then 'bissextile'
    else 'normal'
}
{current-date()}

<bissextile>2020-12-02+01:00</bissextile>
```
如果是闰年则创建bissextile标签并输入`currrent-date()`结果作为值，否则创建normal标签并输入`currrent-date()`的值
### Les commentaires

Un commentaire s'écrit en entourant son contenu avec `(: :)`. Exemple :

``` xquery
(: un commentaire sur une ligne :)

(: Un commentaire
sur plusieurs
lignes :)
```

### Les variables

Une variable est assignée avec la construction `let $nomVar :=` où `$nomVar` désigne le nom attribué (ne pas oublier le `$`). Attention, on utilise l'opérateur `:=`.

``` xquery
let $n := 1
let $s := "Hello"
let $f := upper-case('hello')
```

### Les séquences

Une séquence se déclare comme pour `XPath`, en parenthésant son contenu `( ... )`.

``` xquery
('a', 'b')
('a', 1)
('a', 1, <hello/>)
```

### Concaténation

Il est possible de concaténer des chaînes de caractères avec l'opérateur `||`.

```
'Hello ' || 'world'     'Hello world'
1 || 2                  '12' (type string même si ce sont des nombres)
```

On peut aussi utiliser la fonction `concat()`.

### Application d'une fonction

L'opérateur `!` applique une fonction sur une valeur.

``` xquery
('a', 'b') ! upper-case(.)     'A', 'B'
```

### Chaîner des fonctions

Plutôt que d'enchâsser le contenu des fonctions entre parenthèses à chaque fois, il est possible de les chaîner. Pour cela, on utilise l'opérateur `=>`.

```xquery
tokenize('Hello World', ' ') => reverse() => string-join(' ')   'World Hello'
```

Ici, on n'indique pas l'argument d'entrée de la fonction. Il est implicitement récupéré de la fonction précédente.

### 🌸 FLOWR

La construction la plus importante en `XQuery` est appelée `FLOWR` pour `FOR, LET, ORDER, WHERE, RETURN`.

Celle-ci permet d'itérer sur une séquence et de manipuler les éléments (`for`). On peut déclarer des variables à l'intérieur (`let`), les trier (`order`), appliquer une condition (`where`) et renvoyer le résultat (`return`).

``` xquery
for $x in (1 to 5)        (: Itération à travers une séquence :)
    let $mul := $x * 2    (: Assignation d'une variable :)
    where $x > 2          (: Filtre sur une condition :)
    order by $x mod 3     (: Ordonne les éléments :)
return $x                 (: Retourne le résultat :)

(: Résultat : 3 5 4 :)
```

Les clauses `order` et `where` sont optionnelles.

``` xquery
for $auteur in ('Marcel Arland', 'Jean Paulhan', 'Francis Ponge')
return string-length($auteur)
```

``` xquery
let $words := tokenize('Marcel Arland était à la NRF.', ' ')
return $words
```

想换行可以直接换，`\n`不起作用

On peut utiliser un `XPath` comme point d'entrée.

``` xquery
let $auteurs :=
    <auteurs>
        <auteur prenom="Marcel">Arland</auteur>
        <auteur prenom="Jean">Paulhan</auteur>
        <auteur prenom="Francis">Ponge</auteur>
    </auteurs>
    
for $auteur in $auteurs/auteur
    let $nom := $auteur/text()
    let $prenom := $auteur/@prenom
return $nom ||', '||$prenom

(: Arland, Marcel Paulhan, Jean Ponge, Francis :)
```

#### `group by` 

On peut grouper selon une condition.

``` xquery
let $auteurs :=
    <auteurs>
        <auteur sexe='m' prenom="Marcel">Arland</auteur>
        <auteur sexe='f' prenom="Marguerite">Yourcenar</auteur>
        <auteur sexe='m' prenom="Jean">Paulhan</auteur>
        <auteur sexe='m' prenom="Francis">Ponge</auteur>
        <auteur sexe='f' prenom="Pauline">Réage</auteur>
    </auteurs>

for $auteur in $auteurs/auteur
    let $nom := $auteur/text()
    let $sexe:= $auteur/@sexe
    group by $sexe
return $nom

(: Yourcenar Réage Arland Paulhan Ponge :)
```

Il est possible d'énumérer les résultats avec `count`.

``` xquery
let $auteurs :=
    <auteurs>
        <auteur sexe='m' prenom="Marcel">Arland</auteur>
        <auteur sexe='f' prenom="Marguerite">Yourcenar</auteur>
        <auteur sexe='m' prenom="Jean">Paulhan</auteur>
        <auteur sexe='m' prenom="Francis">Ponge</auteur>
        <auteur sexe='f' prenom="Pauline">Réage</auteur>
    </auteurs>

for $auteur in $auteurs/auteur
    let $nom := $auteur/text()
    order by $nom
    count $num
return $num||'.'||$nom

(: 1.Arland 2.Paulhan 3.Ponge 4.Réage 5.Yourcenar :)
```

### Les espaces de noms

Pour effectuer ses requêtes sur un document comportant un espace de noms, il faut le déclarer au préalable avec `declare namespace prefixe = "uri";`

``` xquery
declare namespace t = "http://www.tei-c.org/ns/1.0";
 
let $ns := t:TEI/name(child::*[1])
return $ns

(: teiHeader :)
```

### Query dans un document

Pour préciser dans quel document on souhaite effectuer la requête, on utilise l'instruction `doc(file:///path)`.

``` xquery
declare namespace t = "http://www.tei-c.org/ns/1.0";
 
let $rom := doc('file:///Rom.xml')

for $editor in $rom//t:editor
return $editor/text()
```

La syntaxe pour ouvrir un document en local est 
`doc("file:///path")`

ou

``` xquery
declare namespace t = "http://www.tei-c.org/ns/1.0";

for $editor in doc('file:///Rom.xml')//t:editor
(:此处会从盘符根目录开始找，因为xq文件存在d盘，所以从d盘根目录找:)
return $editor/text()
```

### `if then else`

Les conditions sont exprimées avec `if then else`. Attention, le `else` est toujours obligatoire ! Si on ne veut rien retourner, alors il faut renvoyer une séquence vide `()`.

``` xquery
for $i in (1 to 10)
return if ($i mod 2 = 0) then $i else 'x'

(: x 2 x 4 x 6 x 8 x 10 :)
```

### Les fonctions

On peut définir ses propres fonctions, pour cela il faut indiquer un espace de noms qui est propre `declare namespace mon-prefixe = "mon-uri";`. La déclaration se termine toujours par un point-virgule `;`.

Ensuite, on déclare la fonction en utilisant ce préfixe.

Les arguments et la valeur de retour doivent être typés ([https://www.w3.org/TR/xpath-datamodel-31/#types-hierarchy](https://www.w3.org/TR/xpath-datamodel-31/#types-hierarchy)). 

Le corps de la fonction est entouré par des accolades, la valeur retournée sera l'évaluation de cette partie.

``` xquery
declare namespace local = "documents-structures-fonctions";

declare function local:bonjour($nom as xs:string) as xs:string {
    "Bonjour, " || $nom
};

local:bonjour('Marcel')

(: Bonjour Marcel :)
```

Parfois, il est nécessaire d'employer le `return` explicitement en retour.

``` xquery
declare namespace local = "documents-structures-fonctions";

declare function local:bonjour($nom as xs:string) as xs:string {
    let $greeting := "Bonjour, " || $nom
    return $greeting
};

local:bonjour('Marcel')

(: Bonjour Marcel :)
```

### Importer ses fonctions

Une fois les fonctions créées, il est possible de se faire sa propre bibliothèque. Pour cela, on peut déclarer un module avec une extension `.xqm`. Ce module contiendra toutes nos fonctions.

Il a une instruction particulière à déclarer au début du fichier : `declare module namespace prefixe="mon-uri"`.

Ensuite, on peut définir nos fonctions.

Le module s'importe avec l'instruction `import module namespace prefixe="mon-uri" at "mon-fichier.xqm"`.

Les fonctions sont utilisables avec le préfixe défini.

### Construire des documents

Nous avons vu au début que l'on pouvait évaluer des expressions avec les accolades. On peut se servir du même mécanisme pour produire d'autres documents.

``` xquery
<ul> {
let $auteurs :=
<auteurs>
<auteur sexe='m' prenom="Marcel">Arland</auteur>
<auteur sexe='f' prenom="Marguerite">Yourcenar</auteur>
<auteur sexe='m' prenom="Jean">Paulhan</auteur>
<auteur sexe='m' prenom="Francis">Ponge</auteur>
<auteur sexe='f' prenom="Pauline">Réage</auteur>
</auteurs>

for $auteur in $auteurs/auteur
return <li>$auteur</li>
}
</ul>
```

Produis le fragment HTML suivant

``` xquery
<ul>
   <li>$auteur</li>
   <li>$auteur</li>
   <li>$auteur</li>
   <li>$auteur</li>
   <li>$auteur</li>
</ul
```

### Enchâsser les `for`

Les boucles ont la possibilité d'être enchâssées.

``` xquery
for $i in (1 to 5)
    for $y in (2, 3)
return $i * $y

(: 2 3 4 6 6 9 8 12 10 15 :)
```

On peut également omettre le second `for`, dans ce cas on sépare les boucles par une virgule

``` xquery
for $i in (1 to 5), $y in (2, 3)
return $i * $y

(: 2 3 4 6 6 9 8 12 10 15 :)
```

## Exercice

### Partie 1

Cet exercice se base sur le [louchébem](https://fr.wikipedia.org/wiki/Louch%C3%A9bem) (qu'on va simplifier).

Le principe consiste à reporter la première consonne du mot à la fin de celui-ci en ajoutant un suffixe `em`. À la place de cette consonne, on ajoute un `L`. Si le mot débute par une voyelle, on ajoute également un  `L` et le suffixe `-bem`. Exemple :

- `argot` : `largotbem`
- `consonne` : `lonsonnecem`
- `boucher` : `loucherbem`

1. Écrire une fonction qui prend en entrée un mot et renvoie celui-ci avec les règles énoncées au dessus. Vous pouvez voir avec [substring](http://www.xqueryfunctions.com/xq/fn_substring.html).

2. Écrire une seconde fonction qui cette fois prend en entrée une phrase et modifie *tous* les mots de celle-ci.

```xquery
declare namespace louchebem = "fonctions-louchebem";

declare function louchebem:mot($mot as xs:string) as xs:string {
    let $voyelles := ("a", "i", "e", "o", "u", "y")
    return
    if (substring($mot,1,1) = $voyelles)
    then "l" || $mot || "bem"
    else substring($mot,2) || substring($mot,1,1) || "em"
};

declare function louchebem:phrase($phrase as xs:string) as xs:string* {
    for $mot in tokenize($phrase, " ")
        return louchebem:mot($mot) || " "
};

<test>
<mot>{louchebem:mot("bad")}</mot>
<phrase>{louchebem:phrase("bad news of today")}</phrase>
</test>


(: Résultat
<test>
   <mot>adbem</mot>
   <phrase>adbem  ewsnem  lofbem  odaytem </phrase>
</test>
:)
```


### Partie 2

En repartant du document `juicers.xml`

1. Écrire une expression pour afficher tous les `@id` des juicers.   
Attention: `$juicer/@id` ou `$juicer/@id/text()` ne fonctionne pas.

```xquery
let $fichier := doc("file:///d:/1-M2/4-Document-structuré/cours7/juicers.xml")
for $juicer in $fichier/juicers/juicer
    return $juicer/@id/string()
```

2. Enrichir celle-ci en triant par le prix (donc les ids seront classés selon le prix des juicers)  (Rajoute `order by`)  
Attention: il faut d'abord transformer en float par `xs:float()`, sinon il va le mettre en ordre par l'ordre de caractères

```xquery
let $fichier := doc("file:///d:/1-M2/4-Document-structuré/cours7/juicers.xml")
for $juicer in $fichier/juicers/juicer
    order by $juicer/xs:float(cost)
    return ($juicer/@id/string(),$juicer/cost/text(), " ")

(: Résultat
 mighty-oj41.95  juiceman-jr82.00  omega234.00  champion239.00  green-power459.99  wheateena639.99 
:)
```

3. Toujours à partir de cette expression, n'afficher que les juicers ayant dans leur nom la chaine `Juicer`.  (Rajoute `where`)  

```xquery
let $fichier := doc("file:///d:/1-M2/4-Document-structuré/cours7/juicers.xml")
for $juicer in $fichier/juicers/juicer
    let $prix := $juicer/xs:float(cost)
    where contains($juicer/name/text(),"Juicer")
    order by $prix
    return ($juicer/name/string(),$juicer/@id/string(),$prix,"    ")
	
(: Résultat
OJ Home Juicer mighty-oj 41.95      Omega Juicer omega 234      Champion Juicer champion 239      Wheateena Wheatgrass Juicer wheateena 639.99 
最后若使用text()则字符串间无空格   
:)
```

**text()是一个node test，而string()是一个函数，data()是一个函数且可以保留数据类型。**
[XPath中的text()和string()区别](https://blog.csdn.net/jiangchao858/article/details/63314426).

### Partie 3

Nous allons créer un module pour compter le nombre de mots dans un texte.

1. Écrire une fonction qui normalise tous les mots d'un texte (mettre en minuscule, retirer la ponctuation) et renvoie une séquence de ceux-ci.
2. Écrire une fonction qui prend en entrée une liste de mots et renvoie leur fréquence (voir [distinct-values](http://www.xqueryfunctions.com/xq/fn_distinct-values.html) et [count](http://www.xqueryfunctions.com/xq/fn_count.html)). Le résultat attendu est le XML suivant :

```xquery
import module namespace cmt="compter-nombre-mots" at "compteur.xqm";

let $t := unparsed-text("file:///d:/1-M2/4-Document-structuré/cours7/texte.txt")
let $lst := cmt:normalisation($t)
return cmt:compteur($lst)
```

```xml
<dictionnaire>
  <mot frequence="5">Le</mot>
  <mot frequence ="1">petit</mot>
  ...
  <mot frequence ="1">chat</mot>
  <mot frequence ="4">dort</mot>
</dictionnaire>
```
