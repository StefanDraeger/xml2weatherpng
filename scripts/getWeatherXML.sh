#!/bin/bash

URL="https://api.meteomatics.com"
USERNAME="xyz"
PASSWORD="abc"
DATE=$(date -u +"%Y-%m-%dT%H:00:00Z")
PARAMS="t_2m:C,relative_humidity_2m:p,weather_symbol_1h:idx"
LAT="52.13858844280108"
LON="10.967010751816423"
FORMAT="xml"

curl -u "${USERNAME}:${PASSWORD}" "https://api.meteomatics.com/${DATE}/${PARAMS}/${LAT},${LON}/${FORMAT}" > wetter.xml