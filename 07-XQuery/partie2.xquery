let $fichier := doc("file:///d:/1-M2/4-Document-structuré/cours7/juicers.xml")
for $juicer in $fichier/juicers/juicer
    let $prix := xs:float($juicer/cost)
    order by $prix
    where contains($juicer/name,"Juicer")
    return $juicer/name/string() || $prix