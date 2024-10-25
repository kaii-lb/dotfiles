#!/bin/sh

read -p "Paste Track ID: " track_id
read -p "Paste Song Name: " song_name

curl "https://spotify-lyric-api-984e7b4face0.herokuapp.com/?trackid=${track_id}&format=lrc" | jq | tail -n +4 | head -n -1 > test.txt


sed  -i '1i {' test.txt
sed -i -e '$a}' test.txt

cat test.txt | jq -r '.lines[] | "[\(.timeTag)] \(.words)"' > "${song_name}".txt
rm test.txt

lyrics=$(cat "${song_name}".txt)

eyeD3 --lyrics=eng:Lyrics:"$lyrics" ""${song_name}".mp3" 1>/dev/null
