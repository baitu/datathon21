<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:cwrc="http://sparql.cwrc.ca/ontologies/cwrc.html"
    xmlns:schema="https://schema.org/"
    xmlns:frbroo="http://iflastandards.info/ns/fr/frbr/frbroo/"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-16" indent="yes"/>
    
    <xsl:template match="/">
        <rdf:RDF xml:lang="en"
            xmlns:frbroo="http://iflastandards.info/ns/fr/frbr/frbroo/"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:schema="https://schema.org/"
            xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/"
            xmlns:cwrc="http://sparql.cwrc.ca/ontologies/cwrc.html"
            xmlns:skos="http://www.w3.org/2004/02/skos/core#"
            xmlns:temp_lincs_temp="http://temp.lincsproject.ca/"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
            <xsl:apply-templates select="descendant::persons"/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="persons">
        <crm:E21_Person rdf:about="uuid:XX"> 
                <xsl:element name="rdf:label">
                    <xsl:value-of select="surname"/>
                </xsl:element>     
            <xsl:apply-templates select="descendant::profession_verbatim"/>
            <xsl:apply-templates select="descendant::social_status/status"/>
            <xsl:apply-templates select="descendant::military_status/status"/>
            <xsl:apply-templates select="descendant::gender"/>
            <xsl:apply-templates select="descendant::street"/>
            
            
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
    
    <xsl:template match="social_status/status">       
            <xsl:choose>
                <xsl:when test=". eq 'Noble'"><cwrc:hasSocialClass rdf:resource="http://sparql.cwrc.ca/testing/cwrc#nobility"/></xsl:when>
                <xsl:when test=". eq 'Commoner'"><cwrc:hasSocialClass rdf:resource="http://sparql.cwrc.ca/testing/cwrc#workingClass"/></xsl:when>
                <xsl:when test=". eq 'Clergy'"><cwrc:hasOccupation rdf:resource="http://sparql.cwrc.ca/ontologies/cwrc#religiousOfficial"/></xsl:when>
            </xsl:choose> 
    </xsl:template>

    <xsl:template match="gender/text()">
        <xsl:variable name="gender" as="xs:string">
            <xsl:choose>
                <xsl:when test=". eq 'M'">man</xsl:when>
                <xsl:when test=". eq 'F'">woman</xsl:when>                
            </xsl:choose>
        </xsl:variable>
        <cwrc:hasGender rdf:resource="{concat('http://sparql.cwrc.ca/testing/cwrc#', $gender)}"/>
    </xsl:template>

    <xsl:template match="military_status/status">       
        <xsl:choose>
            <xsl:when test=". eq 'Civil'"><cwrc:hasSocialClass rdf:resource="uuid:civil"/></xsl:when>
            <xsl:when test=". eq 'Military'"><cwrc:hasOccupation rdf:resource="http://sparql.cwrc.ca/ontologies/cwrc#military"/></xsl:when>
        </xsl:choose> 
    </xsl:template>
    
    <xsl:template match="street">        
           <xsl:apply-templates select="name_new"/>        
    </xsl:template>
    
    <xsl:template match="name_new">    
        <xsl:variable name="streetQ" select="@id"/>
        <schema:streetAddress rdf:resource="{concat('http://www.wikidata.org/wiki/Special:EntityData/',@id)}"/>
    </xsl:template>

</xsl:stylesheet>