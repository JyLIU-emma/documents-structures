<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:template match="services" />
    
    <xsl:template match="ville">
        <xsl:copy>
            <xsl:attribute name="taille">
                <xsl:value-of select="string-length(./text())"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:copy>   
    </xsl:template>
    
    <xsl:template match="adresse">
        <ADRESSE>
            <xsl:value-of select="."/>
        </ADRESSE>
    </xsl:template>
    
    <xsl:template match="prix/@valeur">
        <xsl:attribute name="valeur">
            <xsl:value-of select="concat(round(. * 0.001, 3), '€')"/>
        </xsl:attribute>
    </xsl:template>
    
    
    <xsl:mode on-no-match="shallow-copy"/>
    
</xsl:stylesheet>