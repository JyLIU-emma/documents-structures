<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="pdv_liste">
        <html>
            <head>
                <title>Les points de vente</title>
            </head>
        </html>
        <body>
            <ul>
                <xsl:apply-templates select="pdv/ville"/>
            </ul>   
        </body> 
    </xsl:template>
    
    <xsl:template match="ville">
        <li>
            <xsl:value-of select="./lower-case(text())"/>
        </li>
    </xsl:template>
</xsl:stylesheet>