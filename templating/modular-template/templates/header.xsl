<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template name="header">
        <fo:block font-size="34pt" font-weight="bold" space-after="4pt" text-align="center">Schöningen</fo:block>
    </xsl:template>

    <xsl:template name="header_timestamp">
        <fo:table-cell number-columns-spanned="2" text-align="center">
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
    </xsl:template>


</xsl:stylesheet>