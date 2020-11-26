<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="t"/>
    
    <sch:pattern>
        <sch:rule context="t:TEI">
            <sch:assert test="./t:teiHeader and t:text">Le document doit contient un teiHeader et un text</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule abstract="true" id="contient-p">
            <sch:assert test="self::*[count(child::t:p)=1]">L'élément <sch:name/> doit avoir un enfant p (pas aucun ou plusieurs)</sch:assert>
        </sch:rule>
        
        <sch:rule context="t:sp">
            <sch:extends rule="contient-p"/>
        </sch:rule>
        
        <sch:rule context="t:projectDesc">
            <sch:extends rule="contient-p"/>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern abstract="true" id="structure-acte">
        <sch:rule context="$element">
            <sch:assert test="self::*[count(child::$seule)=1]">L'élement <sch:name/> doit contient un seule $seule</sch:assert>
            <sch:assert test="self::*[count(child::$plusieurs) &gt; 1]">L'élement <sch:name/> doit contient plusieurs $plusieurs</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern is-a="structure-acte" id="act">
        <sch:param name="element" value="t:div[@type='act']"/>
        <sch:param name="seule" value="t:head"/>
        <sch:param name="plusieurs" value="t:div[@type='scene']"/>
    </sch:pattern>
    
</sch:schema>