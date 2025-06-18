<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="tfile" select="document('translations.xml')" />
    <xsl:param name="lang" select="'de'" />

    <!-- Wiederverwendbares Template für eine Wetterbox -->

    <!-- Template zur Darstellung eines Wetterwertes -->
    <xsl:template name="weatherValueBlock">
        <xsl:param name="label"/>
        <xsl:param name="value"/>
        <xsl:param name="unit"/>

        <fo:table-cell>
            <fo:block font-size="4pt">&#160;</fo:block>
            <fo:block>
                <fo:inline font-size="16pt" text-transform="uppercase">
                    <xsl:value-of select="$label"/>
                </fo:inline>
            </fo:block>
            <fo:block font-size="24pt" font-weight="bold">
                <xsl:value-of select="$value"/>
                <fo:inline font-size="16pt" font-weight="normal">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="$unit"/>
                </fo:inline>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template name="showIconWithValue">
        <xsl:param name="icon"/>
        <xsl:param name="value"/>
        <xsl:param name="unit"/>
        <xsl:param name="index" select="1"/>

        <fo:block text-align="center" display-align="center">
            <fo:table>
                <fo:table-column column-width="50px"/>
                <fo:table-column column-width="30px"/>
                <fo:table-column column-width="60px"/>

                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block/>
                        </fo:table-cell>

                        <fo:table-cell>
                            <fo:block>
                                <fo:external-graphic src="url('../images/{$icon}')"
                                                     content-width="30px"/>
                            </fo:block>
                        </fo:table-cell>

                        <fo:table-cell>
                            <fo:block font-size="12pt" font-weight="normal">
                                <xsl:value-of select="$value"/>
                                <xsl:text></xsl:text>
                                <xsl:value-of select="$unit"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="weatherBox">
        <xsl:param name="index"/>
        <xsl:param name="borderLeft" select="false()"/>

        <fo:table-cell>
            <xsl:if test="$borderLeft">
                <xsl:attribute name="border-left">1pt solid #CCCCCC</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="padding-left">4pt</xsl:attribute>
            <xsl:attribute name="padding-right">4pt</xsl:attribute>

            <fo:block font-weight="bold" font-size="12pt" text-align="center">
                <xsl:value-of select="substring(//parameter[@name='t_2m:C']/location/value[$index]/@date, 9, 2)"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="substring(//parameter[@name='t_2m:C']/location/value[$index]/@date, 6, 2)"/>
            </fo:block>

            <fo:block text-align="center" space-before="2pt" space-after="2pt">
                <fo:external-graphic
                        src="url('../images/{//parameter[@name='weather_symbol_1h:idx']/location/value[$index]}.png')"
                        content-width="40px"/>
            </fo:block>

            <fo:block font-size="10pt" font-weight="bold" text-align="center">
                <xsl:call-template name="showIconWithValue">
                    <xsl:with-param name="icon" select="'temperature.png'"/>
                    <xsl:with-param name="value" select="//parameter[@name='t_2m:C']/location/value[$index]"/>
                    <xsl:with-param name="unit" select="'°C'"/>
                </xsl:call-template>

                <xsl:call-template name="showIconWithValue">
                    <xsl:with-param name="icon" select="'humidity.png'"/>
                    <xsl:with-param name="value" select="//parameter[@name='relative_humidity_2m:p']/location/value[$index]"/>
                    <xsl:with-param name="unit" select="'%'"/>
                </xsl:call-template>

                <xsl:call-template name="showIconWithValue">
                    <xsl:with-param name="icon" select="'pressure.png'"/>
                    <xsl:with-param name="value" select="//parameter[@name='msl_pressure:hPa']/location/value[$index]"/>
                    <xsl:with-param name="unit" select="'hPa'"/>
                </xsl:call-template>

            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page" page-width="600px" page-height="475px" margin="15px">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="page">
                <fo:flow flow-name="xsl-region-body">

                    <!-- Ortstitel -->
                    <fo:block font-size="34pt" font-weight="bold" space-after="4pt" text-align="center">Schöningen</fo:block>

                    <!-- Datum und Icon -->
                    <fo:table table-layout="fixed" width="100%" space-after="5pt">
                        <fo:table-column column-width="60%"/>
                        <fo:table-column column-width="40%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2" text-align="center">
                                    <fo:block font-size="12pt" font-weight="bold" space-after="20pt">
                                        <xsl:variable name="datetime" select="/meteomatics-api-response/dateGenerated"/>
                                        <xsl:variable name="year" select="substring($datetime, 1, 4)"/>
                                        <xsl:variable name="month" select="substring($datetime, 6, 2)"/>
                                        <xsl:variable name="day" select="substring($datetime, 9, 2)"/>
                                        <xsl:variable name="time" select="substring($datetime, 12, 5)"/>
                                        <xsl:variable name="txtUhr" select="$tfile/translations/string[@id='uhr']/lang[@code=$lang]"/>


                                        <xsl:value-of
                                                select="concat($day, '.', $month, '.', $year, ' – ', $time, ' ', $txtUhr)"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <!-- Temperatur -->
                            <fo:table-row>
                                <xsl:call-template name="weatherValueBlock">
                                    <xsl:with-param name="label" select="$tfile/translations/string[@id='temperature']/lang[@code=$lang]"/>
                                    <xsl:with-param name="value" select="//parameter[@name='t_2m:C']/location/value[1]"/>
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
                                    <xsl:with-param name="label" select="$tfile/translations/string[@id='humidity']/lang[@code=$lang]"/>
                                    <xsl:with-param name="value" select="//parameter[@name='relative_humidity_2m:p']/location/value[1]"/>
                                    <xsl:with-param name="unit" select="'%'"/>
                                </xsl:call-template>
                            </fo:table-row>
                            <!-- Luftdruck -->
                            <fo:table-row>
                                <xsl:call-template name="weatherValueBlock">
                                    <xsl:with-param name="label" select="$tfile/translations/string[@id='pressure']/lang[@code=$lang]"/>
                                    <xsl:with-param name="value" select="//parameter[@name='msl_pressure:hPa']/location/value[1]"/>
                                    <xsl:with-param name="unit" select="'hPa'"/>
                                </xsl:call-template>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <!-- Vorschau auf die kommenden drei Tage -->
                    <fo:block font-size="16pt" font-weight="bold" space-after="4pt" text-align="center">
                        <xsl:value-of select="$tfile/translations/string[@id='forecast']/lang[@code=$lang]" />
                    </fo:block>

                    <fo:table table-layout="fixed" width="100%" space-after="3pt">
                        <fo:table-column column-width="33%"/>
                        <fo:table-column column-width="33%"/>
                        <fo:table-column column-width="33%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <xsl:call-template name="weatherBox">
                                    <xsl:with-param name="index" select="2"/>
                                    <xsl:with-param name="borderLeft" select="false()"/>
                                </xsl:call-template>
                                <xsl:call-template name="weatherBox">
                                    <xsl:with-param name="index" select="3"/>
                                    <xsl:with-param name="borderLeft" select="true()"/>
                                </xsl:call-template>
                                <xsl:call-template name="weatherBox">
                                    <xsl:with-param name="index" select="4"/>
                                    <xsl:with-param name="borderLeft" select="true()"/>
                                </xsl:call-template>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <!-- Footer -->
                    <fo:block font-size="14pt" font-weight="bold" color="blue" text-align="center" space-before="3pt">
                        Stefan Draeger | https://draeger-it.blog | info@draeger-it.blog
                    </fo:block>

                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
