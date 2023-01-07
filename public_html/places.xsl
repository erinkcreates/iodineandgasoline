<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="1.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" indent="yes" method="html" omit-xml-declaration="yes" />
    <!-- MASTER TEMPLATE. I USE THIS TO ORGANIZE THE BASIC STRUCTURE 
    OF THE OUTPUT DOCUMENT. SO IT WILL INCLUDE BASIC DOCUMENT STRUCTURE TAGS AND
    ANY PULLING/REORGANIZING OF INFORMATION FROM THE ORIGINAL.-->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:title[@type='main']" />
                </title>
                <link rel="stylesheet" type="text/css" href="iodineandgasoline.css"/>
                <link rel="stylesheet" type="text/css" href="fonts.css"/>
                <link href="https://fonts.googleapis.com/css?family=Old+Standard+TT"
                    rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <!-- Begin Site Header -->
                <div class="siteheader">
                    <img
                        alt="Left - photo of officers of the 117th Sanitary Train in Bertricamp, France, April 1918. Right - photo of standard Ford ambulance with storm curtains."
                        src="images/title1.jpg" />
                    <div class="menubar">
                        <div class="menubar-wrapper">
                            <div class="menuitem">
                                <a href="index.html">About</a>
                            </div>
                            <div class="menuitem">
                                <a href="iodineandgasoline.html">Text</a>
                            </div>
                            <div class="menuitem">
                                <a href="people.html">People</a>
                            </div>
                            <div class="menuitem">
                                <a href="places.html">Places</a>
                            </div>
                            <div class="menuitem">
                                <a href="organizations.html">Organizations</a>
                            </div>
                            <div class="menuitem">
                                <a href="iodineandgasoline.xml">XML</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Site Header -->
                <h1> The Geography of <em><xsl:value-of select="//tei:title[@type='main']" /></em>
                </h1>
                <div class="map">
                    <iframe src="https://www.google.com/maps/d/u/0/embed?mid=1nS5wZtJgiEKrgex9zMmgazCLq7E" width="640" height="480"></iframe>
                </div>
                <xsl:call-template name="places" />
            </body>
        </html>
    </xsl:template>

    <xsl:template name="home">
        <a href="iodineandgasoline.html"><h1>Home</h1></a>
    </xsl:template>
    
    <!-- Named Templates -->

    <xsl:template name="places">
        <table>
            <thead>
                <tr>
                    <th> Place </th>
                    <th> Mentions </th>
                    <th>Instances</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="//tei:place">
                    <xsl:variable name="xmlid">
                        <xsl:value-of select="concat('#', @xml:id)" />
                    </xsl:variable>
                    <tr>
                        <td>
                            <p class="place-details">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="@xml:id" />
                                    </xsl:attribute>

                                </xsl:element>
                                <xsl:value-of select="child::*" />
                            </p>
                        </td>
                        <td>
                            <p>
                                <xsl:value-of select="count(//tei:*[@ref=$xmlid])" />
                            </p>
                        </td>
                        <td>
                            <p>
                                <xsl:for-each select="//tei:placeName">
                                    <xsl:variable name="placeNumber" select="position()" />
                                    <xsl:variable name="placeRef">
                                        <xsl:value-of select="@ref" />
                                    </xsl:variable>
                                    <xsl:if test="$xmlid=$placeRef">
                                        <div class="line indent">
                                            <xsl:apply-templates /> (<xsl:value-of
                                                select="$placeNumber" />) </div>
                                    </xsl:if>
                                </xsl:for-each>
                                <xsl:for-each select="//tei:geogName">
                                    <xsl:variable name="geogNumber" select="position()" />
                                    <xsl:variable name="geogRef">
                                        <xsl:value-of select="@ref" />
                                    </xsl:variable>
                                    <xsl:if test="$xmlid=$geogRef">
                                        <div class="line indent">
                                            <xsl:apply-templates /> (<xsl:value-of
                                                select="$geogNumber" />) </div>
                                    </xsl:if>
                                </xsl:for-each>
                            </p>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <!--
        
    <xsl:template name="placeNames">
        <table>
            <thead>
                <tr>
                    <th> place </th>
                    <th>
                        <em>@xml:id</em>
                    </th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="//tei:text/descendant::tei:placeName">
                    <tr>
                        <td>
                            <xsl:value-of select="." />
                            
                        </td>
                        <td>
                            <xsl:value-of select="@ref" />
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>  
    </xsl:template>
    <xsl:template match="//tei:abbr" />
    <xsl:template match="//*[@xml:lang='fr']" />
    <xsl:template name="geog">
        <table>
            <thead>
                <tr>
                    <th>geogName</th>
                    <th>@ref</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="//tei:text/descendant::tei:geogName">
                    <tr>
                        <td>
                            <xsl:value-of select="." />
                            
                        </td>
                        <td>
                            <xsl:value-of select="@ref" />
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template name="blah">
        <ul>
            <xsl:for-each select="//tei:place">
                <xsl:variable name="place">
                    <xsl:value-of select="." />
                </xsl:variable>
                <xsl:variable name="xmlid">
                    <xsl:value-of select="@xml:id" />
                </xsl:variable>
                <p>
                    <strong>
                        <xsl:value-of select="$place" />
                    </strong>
                    <xsl:value-of select="$xmlid" />
                </p>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template name="placeListbody">
        <ul>
            <xsl:for-each select="//tei:body/descendant::tei:placeName">
                <li>
                    <strong>
                        <xsl:apply-templates />
                    </strong>
                    <xsl:value-of select="@ref" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template name="geogListhead">
        <ul>
            <xsl:for-each select="//tei:place/descendant::tei:geogName">
                <li>
                    <strong>
                        <xsl:apply-templates />
                    </strong>
                    <xsl:value-of select="@xml:id" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template name="geogListbody">
        <ul>
            <xsl:for-each select="//tei:body/descendant::tei:geogName">
                <li>
                    <strong>
                        <xsl:apply-templates />
                    </strong>
                    <xsl:value-of select="@ref" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
-->

</xsl:stylesheet>
