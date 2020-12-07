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

```xml
<dictionnaire>
  <mot frequence="5">Le</mot>
  <mot frequence ="1">petit</mot>
  ...
  <mot frequence ="1">chat</mot>
  <mot frequence ="4">dort</mot>
</dictionnaire>
```

Le module :  
```xquery
module namespace cmt = "compter-nombre-mots";

declare function cmt:normalisation($text as xs:string) as xs:string* {
    lower-case($text) => translate("':;.,?!", "") => replace("(\s+)", " ") => tokenize(" ")
};

declare function cmt:compteur($liste as xs:string*) {
<dictionnaire>
    {for $token in distinct-values($liste)
        let $freq := count(for $mot in $liste return if ($mot=$token) then $mot else ())
        return <mot frequence="{$freq}">{$token}</mot>}
</dictionnaire>
};
```

La requête :  
```xquery
import module namespace cmt="compter-nombre-mots" at "compteur.xqm";

let $t := unparsed-text("file:///d:/1-M2/4-Document-structuré/cours7/texte.txt")
let $lst := cmt:normalisation($t)
return cmt:compteur($lst)
```