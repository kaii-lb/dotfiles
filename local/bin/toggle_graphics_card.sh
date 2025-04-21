#!/bin/sh

is_draining=$(nvidia-smi drain -q -p 0000:01:00.0 | rev | cut -f2 -d' ' | rev)

echo -e "Is gpu draining?" $is_draining "\n"

if [[ is_draining == "not" ]]; then
	echo "GPU is not draining, setting to drain"
	sudo nvidia-smi drain -p 0000:01:00.0 -m 1
else
	echo "GPU is draining, setting to not drain"
	sudo nvidia-smi drain -p 0000:01:00.0 -m 0
fi
