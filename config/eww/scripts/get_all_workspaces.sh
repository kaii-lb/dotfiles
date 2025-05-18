#!/usr/bin/env bash

spaces (){
  workspaces=$(hyprctl workspaces -j | jq 'map({id: .id | tostring, windows: .windows}) | sort_by(.id)')
  echo $workspaces
}

spaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  spaces
done
