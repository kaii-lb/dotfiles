#!/bin/sh

count=$(head -n 2 /home/kaii/.cache/notifications.json | grep count | tr -d '["count:", ",", " ", "\"\""]')

string=""

if [[ $count -ge 50 ]]; then
	count=50
fi

for i in $(eval echo "{0..${count}}"); do
	if [[ 0 == $i ]]; then
		string="${i}"
		continue
	fi
	string="${string},${i}"
done

echo "[${string}]"
