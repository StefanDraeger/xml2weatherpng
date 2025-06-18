<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">


    <xsl:template name="generate-content">
        <xsl:param name="name"/>
        <fo:block  font-size="16pt" color="blue" font-weight="bold">
            Guten Tag <xsl:value-of select="$name"/>!
        </fo:block>
    </xsl:template>
</xsl:stylesheet>