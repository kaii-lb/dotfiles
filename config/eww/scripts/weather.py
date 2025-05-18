#! /usr/bin/python3 

import json
import requests
import os

WEATHER_CODES = {
    '113': ' ',
    '116': ' ',
    '119': ' ',
    '122': ' ',
    '143': ' ',
    '176': ' ',
    '179': ' ',
    '182': ' ',
    '185': ' ',
    '200': ' ',
    '227': '🌨 ',
    '230': ' ',
    '248': '🌫 ',
    '260': '🌫 ',
    '263': '🌦 ',
    '266': '🌦 ',
    '281': '🌧 ',
    '284': '🌧 ',
    '293': '🌦 ',
    '296': '🌦 ',
    '299': '🌧 ',
    '302': '🌧 ',
    '305': '🌧 ',
    '308': '🌧 ',
    '311': '🌧 ',
    '314': '🌧 ',
    '317': '🌧 ',
    '320': '🌨 ',
    '323': '🌨 ',
    '326': '🌨 ',
    '329': ' ',
    '332': ' ',
    '335': ' ',
    '338': ' ',
    '350': '🌧 ',
    '353': '🌦 ',
    '356': '🌧 ',
    '359': '🌧 ',
    '362': '🌧 ',
    '365': '🌧 ',
    '368': '🌨 ',
    '371': ' ',
    '374': '🌧 ',
    '377': '🌧 ',
    '386': '⛈ ',
    '389': '🌩 ',
    '392': '⛈ ',
    '395': ' '
}

data = {}

try:
    weather = requests.get("https://wttr.in/Salima+Lebanon?format=j1", timeout=5).json()

    weatherIcon = WEATHER_CODES[weather['current_condition'][0]['weatherCode']]

    data["icon"] = weatherIcon
    data["text"] = weather['current_condition'][0]['temp_C'] + "°C"
except Exception as e:
    data["icon"] = " "
    data["text"] = ""

print(json.dumps(data))

#print(data)
