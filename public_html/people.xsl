<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="1.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" indent="yes" method="html" omit-xml-declaration="yes"/>
    <!-- Master Template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:title[@type='main']"/>
                </title>
                <link rel="stylesheet" type="text/css" href="iodineandgasoline.css"/>
                <link rel="stylesheet" type="text/css" href="fonts.css"/>
                <link href="https://fonts.googleapis.com/css?family=Old+Standard+TT"
                    rel="stylesheet" type="text/css"/>
            </head>
            <body>
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
             
                <div class="orgs-body">
                    <h1> The People of <em><xsl:value-of select="//tei:title[@type='main']"/></em>
                    </h1>
                    <xsl:call-template name="orgs"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="home">
        <a href="iodineandgasoline.html">
            <h1>Home</h1>
        </a>
    </xsl:template>

    <!-- Named Templates -->
    <xsl:template name="orgs">
        <table id="orgs">
            <thead>
                <th>Person</th>
                <th>Mentions</th>
                <th>Information</th>
            </thead>
            <tbody>
                <xsl:for-each select="//tei:person">
                    <xsl:variable name="xmlid">
                        <xsl:value-of select="concat('#', @xml:id)"/>
                    </xsl:variable>
                    <tr>
                        <td>
                            <p class="org-details">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="@xml:id"/>
                                    </xsl:attribute>
                                </xsl:element>
                                <xsl:value-of select="child::*"/>
                            </p>
                        </td>
                        <td>
                            <p>
                                <xsl:value-of select="count(//tei:persName[@ref=$xmlid])"/>
                            </p>
                        </td>
                        <td>
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <!-- Matched Templates -->
    <xsl:template match="//tei:sic"/>
    <xsl:template match="//tei:abbr"/>
</xsl:stylesheet>
