<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
  <xsl:template match="/">
    <html>
      <head>
        <title>COPERAVENTURA S.A.</title>
          <style>
          *{
                margin: 0 auto;
            }
          table {
            border-collapse: collapse;
            margin: 20px auto;
          }
          th, td {
            border: 1px solid black;
            padding: 5px;
            text-align: center;
          }
          th {
            background-color: lightgray;
          }
          h1 {
            
            background-color: orange;
          }
          p {
            font-size: 15px;    
            font-weight: bold;
            text-align: center;
            color: orange;
            background-color: mediumorchid;
            }
            
        </style>
      </head>
      <body>
        <h1><img src="{concat('images/', @logo)}"/><xsl:value-of select="/parc/@nom"/></h1>
        <h1></h1>
        <p>Obrim del <xsl:value-of select="/parc/dates/dataObertura"/> al 
        <xsl:value-of select="/parc/dates/dataTancament"/><br/><br/>NOVEMRE
        </p>
        

        <table border="10">
          <tr>
            <xsl:for-each select="parc/horaris/mes[@nom='Juliol']/periode/diaSetmana">
              <th><xsl:value-of select="."/></th>
            </xsl:for-each>
          </tr>
            <xsl:for-each select="parc/horaris/mes[@nom='Novembre']/periode">
        <tr>
          <xsl:for-each select="diaSetmana">
            <td>
                <xsl:choose>
                    <xsl:when test="@horaObertura and @horaTancament and @diaMes">
                        <div class="dia"><xsl:value-of select="@diaMes"/></div>
                        <div><xsl:value-of select="@horaObertura"/> - <xsl:value-of select="@horaTancament"/></div>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test="@diaMes">
                            <div class="dia"><xsl:value-of select="@diaMes"/></div>
                            TANCAT
                        </xsl:when>
                      </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
          </xsl:for-each>
        </tr>
        </xsl:for-each>
        </table>
        <footer>
          <p><xsl:value-of select="/parc/adreca"/> <br/>
          <xsl:value-of select="/parc/ciutat"/>-
          <xsl:value-of select="/parc/pais"/><br/>
          WEB: <a href="{/parc/paginaWeb}"><xsl:value-of select="/parc/paginaWeb"/></a></p>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
