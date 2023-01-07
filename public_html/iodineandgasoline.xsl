<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="tei" version="1.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" indent="yes" method="html" omit-xml-declaration="yes"/>
    <!-- MASTER TEMPLATE. I USE THIS TO ORGANIZE THE BASIC STRUCTURE 
    OF THE OUTPUT DOCUMENT. SO IT WILL INCLUDE BASIC DOCUMENT STRUCTURE TAGS AND
    ANY PULLING/REORGANIZING OF INFORMATION FROM THE ORIGINAL.-->

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
                <div class="wrapper">
                    <xsl:call-template name="titlePage"/>
                    <xsl:call-template name="tableofcontents"/>
                    <xsl:apply-templates/>
                    <hr />
                    <p class="fine-print">April 28, 2016  |  University of Nebraska-Lincoln</p>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Named Templates in use -->
    <xsl:template name="titlePage">
        <h1>
            <xsl:for-each select="//tei:titlePage[@n='1']/descendant::tei:titlePart">
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:for-each>
        </h1>
        <xsl:for-each select="//tei:pb[@facs='image001']">
            <div class="facsimile firstfacs">
                <xsl:for-each select=".">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('images/large/', @facs, '.jpg')"/>
                        </xsl:attribute>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="concat('images/thumbs/', @facs, '-thumb.jpg')"
                                />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="tableofcontents">
        <div class="tableofcontents">
            <h2>Table of Contents</h2>
            <xsl:for-each select="//tei:div[@type='chapter']">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat('#chapter', @n)"/>
                    </xsl:attribute>
                    <div class="toc-item">
                        <span class="chapter-number">Chapter <xsl:value-of select="@n"/>
                        </span> ........................ <span class="chapter-title">
                            <xsl:value-of select="tei:head[@type='chapTitle']"/>
                        </span>
                    </div>
                </xsl:element>
            </xsl:for-each>
        </div>
    </xsl:template>


    <!-- Matched Templates - tei:front -->

    <xsl:template match="tei:div">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:value-of select="concat(@type, ' ', @type, @n)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:pb[@type='blank']">
        <div class="blank-page">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="//tei:titlePage[@n='2']">
        <div class="titlePage2">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="//tei:figure">
        <div class="figure">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="//tei:head[@type='pagetitle']">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="//tei:titlePage[@n='2']/child::tei:doctitle">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="//tei:titlePage[@type='page']/child::tei:byline">
        <div class="subhead">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="//tei:l">
        <div class="line">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div[@type='property']">
        <div class="property">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div[@type='foreward']">
        <div class="foreward">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div[@type='preface']">
        <div class="preface">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:epigraph">
        <div class="epigraph">
            <em>
                <xsl:apply-templates/>
            </em>
        </div>
    </xsl:template>



    <!-- Matched templates -->
    <xsl:template match="//tei:head[@type='chapTitle']">
        <h2 class="chaptertitle">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="//tei:head[@type='chapNumber']">
        <div class="subhead">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='superscript']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='dropcap']">
        <div class="dropcap">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='uppercase']">
        <span class="uppercase">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="//tei:div[@type='section']/child::tei:head">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="//tei:list">
        <ul>
            <xsl:for-each select="tei:head">
                <h4>
                    <xsl:value-of select="."/>
                </h4>
            </xsl:for-each>
            <xsl:for-each select="tei:item">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="//tei:choice">
        <xsl:value-of select="tei:corr"/>
        <span class="tooltip">&#8224; &#160;<span class="tooltiptext">
                <em>"<xsl:value-of select="tei:sic"/>" [sic]</em>
            </span>
        </span>
    </xsl:template>
    <xsl:template match="tei:sic"/>
    <xsl:template match="//tei:div[@type='chapter']">
        <div class="chapter">
            <xsl:for-each select=".">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:value-of select="concat('chapter', @n)"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:apply-templates/>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="//tei:q"> "<xsl:apply-templates/>" </xsl:template>
    <xsl:template match="//tei:foreign">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="tei:pb">
        <div type="facsimile">
            <hr class="page-divider"/>
            <xsl:for-each select=".">
                <div class="page-frame">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('images/large/', @facs, '.jpg')"/>
                        </xsl:attribute>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="concat('images/thumbs/', @facs, '-thumb.jpg')"
                                />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    <!-- Formworks -->
    <xsl:template match="//tei:fw">
        <div class="fw">
            <xsl:for-each select=".">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@place"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Links to lists and things -->
    <xsl:template match="//tei:persName">
        <xsl:element name="a">
            <xsl:attribute name="class">person</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('people.html', @ref)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:placeName">
        <xsl:element name="a">
            <xsl:attribute name="class">place</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('places.html', @ref)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:orgName">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="concat('organizations.html', @ref)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <!-- Hiding Elements -->
    <xsl:template match="//tei:teiHeader">
        <div style="display:none;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:pb[@facs='image001']"/>
    <xsl:template name="orgList">
        <xsl:for-each select="//tei:orgName">
            <div class="line"><xsl:variable name="orgNameNumber" select="position()"/>
                <xsl:value-of select="$orgNameNumber"/>. <xsl:value-of select="."/>
            </div>
        </xsl:for-each>  
    </xsl:template>
<xsl:template match="//tei:xr">
    <xsl:element name="a">
        <xsl:attribute name="href">
            <xsl:value-of select="@location"/>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
    
    
</xsl:template>
    <!-- Put unused code here for future reference -->

</xsl:stylesheet>
