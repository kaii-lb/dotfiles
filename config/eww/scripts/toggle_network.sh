#!/bin/sh

state=$(nmcli -t -f GENERAL.STATE connection show $1 | sed 's/GENERAL.STATE://' | tr -d ' ')

if [[ $state == "activated" ]]; then
	nmcli connection down $1
else
	nmcli connection up $1
fi
