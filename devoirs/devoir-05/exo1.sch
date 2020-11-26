<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="fermeture">
            <sch:assert test="not(text())">un élément <sch:name/> ne peut contenir de texte</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="ouverture">
            <sch:assert test="@debut and @fin">un élément '<sch:name/> a toujours un début et une fin</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="ouverture" role="warn">
            <sch:report test="@saufjour eq ''">Ce point de vente devrait prendre des vacances</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="ville" role="warn">
            <sch:report test="text() != upper-case(text())">Les noms des villes devraient être tous en majuscule pour la consistance</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>