#!/bin/bash

INTERFACE_NODE="alsa_output.usb-Topping_E2x2-00.analog-surround-21"

LINKS=(
    "alsa_input.usb-Topping_E2x2-00.analog-surround-21:capture_FL interface-in1_l:input_MONO"
    "alsa_input.usb-Topping_E2x2-00.analog-surround-21:capture_FR interface-in2_r:input_MONO"
    "sm57-carla:capture_FL $INTERFACE_NODE:playback_FL"
    "sm57-carla:capture_FR $INTERFACE_NODE:playback_FR"
    "soundboard_audio_sink:monitor_FL sm57-carla:input_FL"
    "soundboard_audio_sink:monitor_FR sm57-carla:input_FR"
    "chat_audio_sink:monitor_FL alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FL"
    "chat_audio_sink:monitor_FR alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FR"
    "game_audio_sink:monitor_FL alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FL"
    "game_audio_sink:monitor_FR alsa_output.usb-Topping_E2x2-00.analog-surround-21:playback_FR"
)

link () {
    echo linking

    for link in "${LINKS[@]}"; do
        pw-link $link 2>/dev/null
    done
}

echo "monitoring for $INTERFACE_NODE"

while true; do
    if pw-dump | grep -q "node\\.name\": \"$INTERFACE_NODE"; then
        link

        while pw-dump | grep -q "node\\.name\": \"$INTERFACE_NODE"; do
            sleep 1
        done

        echo "device lost"
    fi

    sleep 1
done