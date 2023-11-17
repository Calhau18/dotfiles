PLAYERS=$(playerctl status -a --format '{{playerName}} {{status}}' | grep 'Playing' | cut -f1 -d' ')
if [ -z "$PLAYERS" ]; then
    PLAYERS=$(playerctl -l)
fi

if [[ $PLAYERS == *'spotify'* ]]; then
    PLAYER='spotify'
else
    PLAYER=$(echo "$PLAYERS" | head -n1)
fi

echo $(playerctl metadata --format '{{artist}} - {{title}}' --player=$PLAYER)
