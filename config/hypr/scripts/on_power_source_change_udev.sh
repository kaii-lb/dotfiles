#!/bin/sh

systemctl --user --machine=kaii@.host start on_power_source_change.service

#!/bin/sh

export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR=/run/user/1000

# echo "hello" > /home/kaii/TESTING.log

is_ac=$(systemd-ac-power -v)

echo Is on AC? $is_ac

if [[ $is_ac == "yes" ]]; then
	sed -i -e 's/PowerSave/Gaming/g' /etc/scx_loader.toml
	systemctl restart scx_loader.service
	ip link set enp7s0 up
	modprobe uvcvideo
	rfkill unblock all
else
	sed -i -e 's/Gaming/PowerSave/g' /etc/scx_loader.toml
	systemctl restart scx_loader.service
	ip link set enp7s0 down
	modprobe -r uvcvideo
	pidof spotify || rfkill block bluetooth
fi
