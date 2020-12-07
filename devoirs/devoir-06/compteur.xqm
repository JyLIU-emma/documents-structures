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


