#!/bin/bash

sleep 2

pw-link sm57-carla:capture_FL alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FL
pw-link sm57-carla:capture_FR alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FR
pw-link soundboard_audio_sink:monitor_FL sm57-carla:input_FL
pw-link soundboard_audio_sink:monitor_FR sm57-carla:input_FR