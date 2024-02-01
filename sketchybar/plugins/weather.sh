#!/usr/bin/env zsh

IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)

LOCATION="$(echo $LOCATION_JSON | jq '.city' | tr -d '"')"
REGION="$(echo $LOCATION_JSON | jq '.region' | tr -d '"')"
COUNTRY="$(echo $LOCATION_JSON | jq '.country' | tr -d '"')"

# IP  is never accurate
LOCATION="Town Here"
REGION="State Here"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")

# Fallback if empty
if [ -z $WEATHER_JSON ]; then

    sketchybar --set $NAME label=$LOCATION
    sketchybar --set $NAME.icon icon=

    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_F' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')

WEATHER_CODE=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherCode' | tr -d '"')

echo "$TEMPERATURE"
echo $"WEATHER_DESCRIPTION"
echo "$WEATHER_CODE"

case $WEATHER_CODE in
  # Sunny
  "113" | "116" | "119" | "122" | "143" | "176" | "179" | "182" | "185" | "200")
    ICON="󰖙"
    ;;
  # Light Rain
  "266" | "281" | "284" | "293" | "296")
    ICON=""
    ;;
  # Light Sleet
  "311" | "314" | "317" | "350")
    ICON=""
    ;;
  # Light Snow
  "227" | "320")
    ICON=""
    ;;
  # Light Snow Showers
  "323" | "326" | "368")
    ICON=""
    ;;
  # Heavy Snow
  "230" | "332" | "335" | "338" | "329" | "371" | "395")
    ICON=""
    ;;
  # Light Showers
  "263" | "353")
    ICON=""
    ;;
  # Heavy Showers
  "356" | "359")
    ICON=""
    ;;
  # Heavy Rain
  "302" | "305" | "308")
    ICON=""
    ;;
  # Light Sleet Showers
  "179" | "362" | "365" | "374")
    ICON=""
    ;;
  # Thundery Showers
  "386")
    ICON="󰙾"
    ;;
  # Thundery Heavy Rain
  "389")
    ICON="󰙾"
    ;;
  # Thundery Snow Showers
  "392")
    ICON=""
    ;;
  *)
    echo "Weather code not recognized."
    ;;
esac

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE $WEATHER_DESCRIPTION"
sketchybar --set $NAME.icon icon=$ICON
