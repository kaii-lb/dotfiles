#!/bin/sh

#echo $(sensors -j 2> /dev/null | jq '."coretemp-isa-0000"."Package id 0"."temp1_input"|tostring|split(".")[0]|tonumber')
echo $(sensors -j 2> /dev/null | jq '."coretemp-isa-0000"."Core 20"."temp22_input"|tostring|split(".")[0]|tonumber')
