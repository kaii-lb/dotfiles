#!/bin/sh

read -e -p 'File Name: ' -r fileName

realPath=`realpath ${fileName}`

videoFullPath="${realPath}video.webm"
audioFullPath="${realPath}audio.webm"

read -e -p 'Video Title: ' -r videoTitle

ffmpeg -i "${videoFullPath}"  -i "${audioFullPath}" -c:v copy -c:a aac "${videoTitle}.mp4"

mv "${videoFullPath}" $HOME/.local/share/Trash/files;
mv "${audioFullPath}" $HOME/.local/share/Trash/files;
