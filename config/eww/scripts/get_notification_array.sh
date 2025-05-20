#!/bin/sh

count=$(head -n 2 ~/.cache/notifications.json | grep count | tr -d '["count:", ",", " ", "\"\""]')

string=""

for i in $(eval echo "{0..${count}}"); do
	if [[ 0 == $i ]]; then
		string="${i}"
		continue
	fi
	string="${string},${i}"
done

echo "[${string}]"
