#!/bin/sh

MP3_DIR="/opt/muos/theme/music"
LAST_PLAY="/opt/muos/theme/lastbgm.txt"

while true; do
	cd "$MP3_DIR" || exit 1
	touch "$LAST_PLAY"

	MP3_FILES=$(find . -maxdepth 1 -type f -name "*.mp3" -a ! -name "$(cat "$LAST_PLAY")")

	if [ -n "$MP3_FILES" ]; then
		LINES=$(echo "$MP3_FILES" | wc -l)
		R_LINE=$(awk -v min=1 -v max="$LINES" 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')

		MP3_SELECT=$(echo "$MP3_FILES" | sed -n "${R_LINE}p")

		echo "$(basename "$MP3_SELECT")" > "$LAST_PLAY"
		/opt/muos/bin/mp3play "$MP3_SELECT"
	fi

	sleep 3
done &
