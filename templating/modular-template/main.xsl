<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:include href="/mnt/c/Users/stefa/IdeaProjects/xml2weatherpng/templating/modular-template/templates/header.xsl"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page" page-width="600px" page-height="475px" margin="15px">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="page">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="header"/>
                    <fo:table table-layout="fixed" width="100%" space-after="5pt">
                        <fo:table-column column-width="60%"/>
                        <fo:table-column column-width="40%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <xsl:call-template name="header_timestamp"/>
                            </fo:table-row>
                            <!-- Temperatur -->
                            <fo:table-row>
                                <xsl:call-template name="weatherValueBlock">
                                    <xsl:with-param name="label" select="'TEMPERATUR'"/>
                                    <xsl:with-param name="value"
                                                    select="//parameter[@name='t_2m:C']/location/value[1]"/>
                                    <xsl:with-param name="unit" select="'°C'"/>
                                </xsl:call-template>
                                <fo:table-cell number-rows-spanned="3" display-align="center">
                                    <fo:block text-align="center">
                                        <fo:external-graphic
                                                src="url('../images/{concat(//parameter[@name='weather_symbol_1h:idx']/location/value[1], '.png')}')"
                                                content-width="140px"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <!-- Luftfeuchtigkeit -->
                            <fo:table-row>
                                <xsl:call-template name="weatherValueBlock">
                                    <xsl:with-param name="label" select="'LUFTFEUCHTIGKEIT'"/>
                                    <xsl:with-param name="value"
                                                    select="//parameter[@name='relative_humidity_2m:p']/location/value[1]"/>
                                    <xsl:with-param name="unit" select="'%'"/>
                                </xsl:call-template>
                            </fo:table-row>
                            <!-- Luftdruck -->
                            <fo:table-row>
                                <xsl:call-template name="weatherValueBlock">
                                    <xsl:with-param name="label" select="'LUFTDRUCK'"/>
                                    <xsl:with-param name="value"
                                                    select="//parameter[@name='msl_pressure:hPa']/location/value[1]"/>
                                    <xsl:with-param name="unit" select="'hPa'"/>
                                </xsl:call-template>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <xsl:call-template name="footer"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>