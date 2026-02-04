#!/bin/sh

notifs=$(dunstctl history | jq ".data[0]")

array=$(while read row; do
	ts=$(echo "$row" | jq -r '.timestamp.data | tostring')
	formatted=$($HOME/.config/quickshell/scripts/get_dunst_timestamp.sh $ts)

	new=$(echo "$row" | jq --argjson v "\"$formatted\"" '.timestamp.data = $v')
	echo $new
done <<< "$(echo $notifs | jq -c '.[]')")

echo $array | jq -s -c '.'
