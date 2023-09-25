#!/bin/bash

bluetoothctl devices Connected | cut -f2 -d' ' 
