#!/bin/bash

LOGFILE="forecast.log"
DATETIME=$(date '+%Y-%m-%d %H:%M:%S')

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"
}

log "START"

URL="https://api.meteomatics.com"
USERNAME="xyz"
PASSWORD="abc"
DATE=$(date -u +"%Y-%m-%dT%H:00:00Z")
PARAMS="t_2m:C,relative_humidity_2m:p,weather_symbol_1h:idx"
LAT="52.13858844280108"
LON="10.967010751816423"
FORMAT="xml"
if curl -u "${USERNAME}:${PASSWORD}" "https://api.meteomatics.com/${DATE}/${PARAMS}/${LAT},${LON}/${FORMAT}" > wetter.xml; then
    log "Holen der Daten von ${URL} erfolgreich"
else
    log "Fehler beim Abrufen der Wetterdaten von ${URL}"
    exit 1
fi

if ./fop/fop -xml wetter.xml -xsl meteomatics2fo.xsl -png output/forecast.png; then
    log "Transformieren in Datei output/forecast.png erfolgreich"
else
    log "Fehler beim Transformieren der Datei"
    exit 1
fi


if scp ./output/forecast.png ssh-user@domain.com:/www/htdocs/path/wetterdisplay/forecast.png; then
    log "Upload via SCP erfolgreich"
else
    log "Fehler beim SCP-Upload"
    exit 1
fi

log "ENDE"