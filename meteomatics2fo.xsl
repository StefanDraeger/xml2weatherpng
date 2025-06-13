<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page" page-width="400px" page-height="300px" margin="15px">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="page">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="34pt" font-weight="bold" space-after="8pt">Schöningen</fo:block>
                    <fo:table table-layout="fixed" width="100%" space-after="10pt">
                        <fo:table-column column-width="60%"/>
                        <fo:table-column column-width="40%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block font-size="12pt" font-weight="bold" space-after="20pt">
                                        <xsl:variable name="datetime" select="/meteomatics-api-response/dateGenerated"/>
                                        <xsl:variable name="year" select="substring($datetime, 1, 4)"/>
                                        <xsl:variable name="month" select="substring($datetime, 6, 2)"/>
                                        <xsl:variable name="day" select="substring($datetime, 9, 2)"/>
                                        <xsl:variable name="time" select="substring($datetime, 12, 5)"/>

                                        <xsl:value-of
                                            select="concat($day, '.', $month, '.', $year, ' – ', $time, ' Uhr')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-rows-spanned="3" display-align="center">
                                    <fo:block text-align="center">
                                        <fo:external-graphic
                                            src="url('images/{concat(//parameter[@name='weather_symbol_1h:idx']/location/value, '.png')}')"
                                            content-width="180px"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block font-size="16pt">&#160;</fo:block>
                                    <fo:block>
                                        <fo:inline font-size="18pt">TEMPERATUR</fo:inline>
                                    </fo:block>

                                    <fo:block font-size="32pt" font-weight="bold">
                                        <xsl:value-of select="//parameter[@name='t_2m:C']/location/value"/>
                                        <fo:inline font-size="18pt">°C</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block font-size="16pt">&#160;</fo:block>
                                    <fo:block>
                                        <fo:inline font-size="18pt">LUFTFEUCHTIGKEIT</fo:inline>
                                    </fo:block>

                                    <fo:block font-size="32pt" font-weight="bold">
                                        <xsl:value-of
                                            select="//parameter[@name='relative_humidity_2m:p']/location/value"/>
                                        <fo:inline font-size="18pt">%</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
