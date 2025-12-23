#!/bin/bash

sleep 5

PW_LINK="/usr/bin/pw-link"
PW_JACK="/usr/bin/pw-jack"

"$PW_LINK" sm57-carla:capture_FL alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FL
"$PW_LINK" sm57-carla:capture_FR alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FR
