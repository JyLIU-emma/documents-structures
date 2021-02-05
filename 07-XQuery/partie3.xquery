import module namespace cmt="compter-nombre-mots" at "compteur.xqm";

let $t := unparsed-text("file:///d:/1-M2/4-Document-structuré/cours7/texte.txt")
let $lst := cmt:normalisation($t)
return cmt:compteur($lst)


