#!/bin/bash

# eval "$(date +'today=%F now=%s')"
# midnight=$(date -d "$today 0" +%s)
# time_since_midnight=$((now - midnight))
# time_in_hours=$((time_since_midnight / 3600))
# 
# if [[ time_since_midnight != 86400 ]]; then
	# notify-send "Too early to run script now." "Its ${time_in_hours}hrs too early"
	# exit 0;
# fi

var=$(cat /home/$USER/.local/bin/value-holder-for-reminder.txt)

cat /home/$USER/.local/bin/value-holder-for-reminder.txt

# while IFS= read -r line; do
  # if [[ line == ${var}* ]]; then
  	# 
# done < "/home/kai/test.txt" didn't even try with lol

#sed -n '${var}p' < /home/kai/test.txt doens't work fsr


echo $var

name=$(awk 'NR == var'var=$var /home/$USER/.local/bin/question.txt)

notify-send -u critical "${name}" "..is your daily question"

if [[ $(cat /home/$USER/.local/bin/value-holder-for-reminder.txt) -eq 30 ]]; then
	rm /home/$USER/.local/bin/value-holder-for-reminder.txt
	echo 1 >> /home/$USER/.local/bin/value-holder-for-reminder.txt
else
	rm /home/$USER/.local/bin/value-holder-for-reminder.txt
	echo $(($var + 1)) >> /home/$USER/.local/bin/value-holder-for-reminder.txt 
fi
