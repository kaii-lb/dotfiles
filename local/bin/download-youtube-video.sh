#!/bin/sh

# read -e -p 'Video File Name: ' -r videoFileName
# read -e -p 'Audio File Name: ' -r audioFileName


# Color       #define       Value       RGB
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max


cd $HOME/

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)
NC=$(tput sgr0) #no color

set -e
shopt -s extglob

videoLink=$1
returnAfterAudio=false

if [ -z "${2}" ]; then
	res=$( { yt-dlp "${videoLink}" -F || echo 0; } | tail -n1 | cut -d' ' -f1)
elif [ "${2}" -eq 720 ]; then
	res=247;
elif [	"${2}" -eq 480 ]; then
	res=244;
elif [	"${2}" -eq 360 ]; then
	res=243;
elif [	"${2}" -eq 240 ]; then
	res=242;	
elif [ "${2}" -eq 1 ]; then
	res=251
	returnAfterAudio=true;
fi	

videoLink=`echo ${videoLink} | cut -f1 -d"&"`
echo $videoLink
title=$( { yt-dlp --get-title "${videoLink}"|| echo 0; } | tail -n1 )
#title=$(echo $videoFileName	| sed -i 's///|/g')
echo "${GREEN}${title}${NC}"


randomVidID=`tr -dc A-Za-z </dev/urandom | head -c 6`

if [ "${returnAfterAudio}" = true ]; then
	yt-dlp "${videoLink}" -f 251 -o "${title}"
	ffmpeg -i "${title}" -vn -ar 44100 -ac 2 -b:a 192k "${title}.mp3"
	rm "${title}"
	exit 0
fi 

yt-dlp "${videoLink}" -f "$res" -o "${randomVidID}.temp-video.webm"
yt-dlp "${videoLink}" -f 251 -o "${randomVidID}.temp-audio.webm" 

videoFullPath=`realpath ${randomVidID}.temp-video.webm | tr -d '\\\'`
audioFullPath=`realpath ${randomVidID}.temp-audio.webm | tr -d '\\\'`

echo -e "${GREEN}Video Path: $videoFullPath \nAudio Path: $audioFullPath \nEnd Path: ${BLUE} ${title}.mp4${NC}"

# rimmedVideoFileName=$(echo $videoFileName	| cut -f1 -d"[")
# trimmedVideoFileName=`echo $trimmedVideoFileName | tr -d '\'`

ffmpeg -i "${videoFullPath}"  -i "${audioFullPath}"  -c:v copy -c:a aac "${title}.mp4"
mv "${videoFullPath}" $HOME/.local/share/Trash/files
mv "${audioFullPath}" $HOME/.local/share/Trash/files

if [ -z "${videoFullPath}.part" ]; then
	mv "${videoFullPath}.part" $HOME/.local/share/Trash/files;
elif [ -z "${audioFullPath}.part" ]; then
	mv "${audioFullPath}.part" $HOME/.local/share/Trash/files;
fi
