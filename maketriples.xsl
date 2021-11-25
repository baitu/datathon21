<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:frbroo="http://iflastandards.info/ns/fr/frbr/frbroo/"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-16" indent="yes"/>

    <xsl:template match="/">
        <rdf:RDF xml:lang="en"
            xmlns:frbroo="http://iflastandards.info/ns/fr/frbr/frbroo/"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/"
            xmlns:skos="http://www.w3.org/2004/02/skos/core#"
            xmlns:temp_lincs_temp="http://temp.lincsproject.ca/"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
            <xsl:apply-templates select="descendant::persons"/>
        </rdf:RDF>
    </xsl:template>

    <xsl:template match="persons">
        <crm:E21_Person rdf:about="uuid:XX"> <!--concat URI-->
            <rdfs:label>
                <xsl:value-of select="surname"/>
            </rdfs:label>

            <xsl:apply-templates select="descendant::profession_verbatim"/>

        </crm:E21_Person>
    </xsl:template>

    <xsl:template match="profession_verbatim">
            <crm:P14i_performed>
                <frbroo:F51_Pursuit rdf:about="uuid:XX">
                    <rdfs:label>
                        <xsl:value-of select="."/>
                    </rdfs:label>
                </frbroo:F51_Pursuit>
            </crm:P14i_performed>
    </xsl:template>

</xsl:stylesheet>
