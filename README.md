Dieses Projekt zeigt, wie man Wetterdaten von [meteomatics.com](https://www.meteomatics.com/) im XML-Format mit **XSLT** und **Apache FOP** in ein grafisches **PNG-Bild** umwandelt. Das Ergebnis eignet sich ideal zur Anzeige auf stromsparenden ePaper-Displays wie z. B. dem Inkplate 6".

## 📁 Projektstruktur
<br>
xml2weatherpng/<br>
├── images/                 # Icons für Wetterlagen (umbenannt für XSLT-Zugriff)<br>
├── output/                 # Ausgabeordner für das generierte PNG-Bild<br>
├── scripts/                # Hilfsskripte für einzelne Teilschritte<br>
├── meteomatics2fo.xsl      # XSLT-Template zur Umwandlung von XML in XSL-FO<br>
├── meteomatics\_fetch.sh    # Shell-Skript für alle Schritte: Download, Transformation, Upload<br>

## ⚙️ Projektfunktion

Das Shell-Skript `meteomatics_fetch.sh` automatisiert:

1. Abruf der Wetterdaten via `curl` von meteomatics.com  
2. Umwandlung des XMLs mit `meteomatics2fo.xsl` in XSL-FO  
3. Generierung eines PNG-Bildes mit **Apache FOP**  
4. Optional: Upload des fertigen Bildes auf deinen Webserver via `scp`

## 🔐 SSH-Zugriff für automatisierten Upload

Wenn du das Bild per SCP hochladen möchtest, ohne bei jedem Upload dein Passwort eingeben zu müssen:

```bash
ssh-keygen -t rsa -b 4096 -C "dein@email.de"
ssh-copy-id benutzer@domain.de
scp ./output/forecast.png benutzer@domain.de:/pfad/zum/verzeichnis/
````

## 🧰 Voraussetzungen

* Linux-Shell (z. B. WSL unter Windows)
* Apache FOP
* Java (Installation z. B. über `sudo apt install default-jre`)
* Kostenloser meteomatics-Account:
  👉 [https://www.meteomatics.com/en/sign-up-weather-api-free-basic-account/](https://www.meteomatics.com/en/sign-up-weather-api-free-basic-account/)
* Geokoordinaten deines Standorts (Latitude & Longitude)

## 🔗 Weitere Infos

📝 Blogbeitrag:
[Wetterdaten visualisieren mit XSLT & Apache FOP – Teil 1](https://draeger-it.blog/wetterdaten-visualisieren-mit-xslt-apache-fop-teil-1-png-erzeugung-am-pc/)

💻 GitHub Repository:
[https://github.com/StefanDraeger/xml2weatherpng](https://github.com/StefanDraeger/xml2weatherpng)

## 👤 Autor

**Stefan Draeger**
🌐 [https://draeger-it.blog](https://draeger-it.blog)
