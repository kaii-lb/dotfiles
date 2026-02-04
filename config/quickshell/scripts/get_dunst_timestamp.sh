#!/bin/sh

# taken from https://github.com/dunst-project/dunst/issues/10019
dunst_ts_to_unix() {
	# nanoseconds to seconds
	local dunst_ts=$(($1 / 1000000))
	# time since boot
	local seconds_uptime=$(date +%s -d@$(cut -d' ' -f1 /proc/uptime))
	# current time
	local ts_now=$(date +%s)

	echo $((ts_now - seconds_uptime + dunst_ts))
}

check_is_now() {
	ts=$(dunst_ts_to_unix $1)
	now=$(date +%s)

	diff=$((now - ts))

	if [[ $diff -lt 60 ]]; then
		echo "now"
	elif [[ $diff -lt 3600 ]]; then
		mins=$(date +%-M -d@$diff)
		echo ${mins}m ago
	elif [[ $diff -lt 86400 ]]; then
		mins=$(date +%-H -d@$diff)
		echo ${mins}h ago
	else
		echo $(date +'%-H:%-M:%-S %a %d %b %Y')
	fi
}


check_is_now $1
