#1/bin/sh

networks=$(echo "$(nmcli -t -f NAME,TYPE,STATE connection show)" | sed '/^lo/d' | sed '/^NAME/d' | jq -sR 'split("\n") | map(split(":")) | map({"name": .[0],"type": .[1] | tostring | split("-") | last,"state": .[2]} | select(.name != null))')
length=$(echo $networks | jq length)
length=$((length - 1))
string=""

for i in $(eval echo "{0..${length}}"); do
	if [[ 0 == $i ]]; then
		string="${i}"
		continue
	fi
	string="${string},${i}"
done


echo "{\"count\": \"[${string}]\", \"items\": ${networks}}" | tr -d '\n'
echo

nmcli monitor | while read -r line; do
	networks=$(echo "$(nmcli -t -f NAME,TYPE,STATE connection show)" | sed '/^lo/d' | sed '/^NAME/d' | jq -sR 'split("\n") | map(split(":")) | map({"name": .[0],"type": .[1] | tostring | split("-") | last,"state": .[2]} | select(.name != null))')
	length=$(echo $networks | jq length)
	length=$((length - 1))
	string=""

	for i in $(eval echo "{0..${length}}"); do
		if [[ 0 == $i ]]; then
			string="${i}"
			continue
		fi
		string="${string},${i}"
	done


	echo "{\"count\": \"[${string}]\", \"items\": ${networks}}" | tr -d '\n'
	echo
done
