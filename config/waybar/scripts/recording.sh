#!/bin/sh

if pgrep -x "wl-screenrec" > /dev/null
then
    status="Running"
else
    status="Stopped"
fi

echo "{\"alt\": \"$status\"}"

