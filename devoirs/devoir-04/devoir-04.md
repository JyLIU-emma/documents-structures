## cours_xpath-01.md
### Partie 2

À partir du fichier `PDV.xml`

1. L'élément racine du document
`/`
2. Tous les noeuds enfants de `<pdv>`
`/pdv_liste/pdv/child::*`
3. Les noeuds textes de toutes les villes
`/pdv_liste/pdv/ville/text()`
4. Le 46ième point de vente
`/pdv_liste/pdv[46]`
5. Le dernier élément `<prix>` de chaque point de vente
`/pdv_liste/pdv/prix[last()]`
6. Le point de vente dont l'ID est 3150005
`/pdv_liste/pdv[@id = "3150005"]`
7. Les points de vente qui ne proposent pas de "GPL" 
`/pdv_liste/pdv[child::services [not(child::service[text() = "GPL"])]]`
8. Tous les noeuds frères à droite de l'élément `<services>`
`/pdv_liste/pdv/services/following-sibling::*`
9. La ou les ville(s) dont le code postal est 16170
`/pdv_liste/pdv[@cp = "16170"]/ville`
10. Les points de vente qui ne sont pas ouverts le lundi
`/pdv_liste/pdv[ouverture/@saufjour = "Lundi"]`
11. Les points de vente ouvrant le service "Relais colis"
`/pdv_liste/pdv[descendant::service/text() = "Relais colis"]`
12. Le ou les éléments dont le 10ième élément venant à droite a pour valeur textuelle "Piste poids lourds"
`//*[following::*[10]/text() = "Piste poids lourds"]`
13. La ou les ville(s) dont le point de vente a été en rupture de "SP95" le 04 février 2013
`//pdv[rupture[@nom = "SP95" and contains(@début,"2013-02-04")]]`
14. Tous les points de vente qui n'ont pas connu de fermeture
`//pdv[fermeture[not(node())]]`
15. Est-ce que la ville de La Mure propose du carburant E10 ? Écrire la requête.
`/pdv_liste/pdv[ville = "La Mure" and prix/@nom = "E10"]`
16. Combien existe t-il de points de vente ? 10824
`/pdv_liste/count(pdv)`
17. Écrire une expression pour compter la longueur de la chaîne de caractères des éléments `<adresse>`
`//adresse/string-length(text())`
18. Reprendre cette expression et trouver la valeur maximale  75
`max(//adresse/string-length(text()))`
19. Selectionner les points de vente qui ne ferment pas à `20:00`
`/pdv_liste/pdv[ouverture/@fin != "20:00"]`
20. Afficher le nom des différents carburants proposés en minuscule
`distinct-values(//pdv/prix/lower-case(@nom))`
21. Remplacer le point contenu dans l'attribut `latitude` par `--` (Attention, il faudra échapper le point)
`//pdv/translate(@latitude,".","--")`
22. Inverser la date et l'heure dans les attributs `maj`, et changer le séparateur par `T` (t majuscule)
`//pdv/prix/string-join((substring-after(@maj ," "),substring-before(@maj , " ")),"T")`

---
## cours_xpath-02.md
### Exercice

En repartant du fichier `juicers.html`

1. Créer une séquence contenant les `juicer` de type centrifugeuse
`//juicer[@type = "centrifugal"]`
2. Sélectionner la dernière machine (= dernier `juicer`) à partir de cette séquence
`//juicer[@type = "centrifugal"][last()]`
3. Supprimer la deuxième machine de cette séquence
`//juicer[@type eq "centrifugal"][not(position() eq 2)]`
4. Créer une séquence du nom des machines, la séquence doit contenir des chaînes de caractères
`//juicer/name/string()`
5. Afficher la position de la machine ayant pour nom `Juiceman Jr.`   4
`index-of(//juicer, //juicer[name/string() = "Juiceman Jr."])`
6. Créer une séquence avec les noeuds contenant le nom des machines
`//juicer/name`
7. Afficher la position du noeud contenant une balise `name` ayant pour valeur `Juiceman Jr.`  24
`index-of(//*, //name[text() = "Juiceman Jr."])`
8. Créer une séquence d'entier allant de 5 à 25 (Note : ne fonctionne que pour des entiers)
`(5 to 25)`
9. Afficher tous les multiples de 5 de cette séquence
```xml
for $i in (5 to 25)
return if ($i mod 5 eq 0) then $i
else()
```