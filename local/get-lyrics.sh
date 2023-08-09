#!/bin/sh

read -p "Paste Track ID: " track_id
read -p "Paste Song Name: " song_name

curl "https://spotify-lyric-api.herokuapp.com/?trackid=${track_id}&format=lrc" | jq | tail -n +4 | head -n -1 > test.txt

echo $lyrics

sed  -i '1i {' test.txt
sed -i -e '$a}' test.txt

cat test.txt | jq -r '.lines[] | "[\(.timeTag)] \(.words)"' > "${song_name}".txt
