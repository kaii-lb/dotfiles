#!/bin/bash

bluetoothctl devices Connected | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid | grep 'Device' | cut -f2 -d' '; done
