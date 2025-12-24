#!/bin/bash

APP_NAME="Topping E2x2 Monitor"
INTERFACE_NAME="Topping E2x2"
INTERFACE="usb-Topping_E2x2-00.analog-surround-21"
INTERFACE_OUTPUT_NODE="alsa_output.$INTERFACE"
INTERFACE_INPUT_NODE="alsa_input.$INTERFACE"
NOTIF_TAG="string:x-canonical-private-synchronous:topping-e2x2-link"

LINKS=(
	"$INTERFACE_INPUT_NODE:capture_FL interface-in1_l:input_MONO"
	"$INTERFACE_INPUT_NODE:capture_FR interface-in2_r:input_MONO"
	"sm57-carla:capture_FL $INTERFACE_OUTPUT_NODE:playback_FL"
	"sm57-carla:capture_FR $INTERFACE_OUTPUT_NODE:playback_FR"
	"soundboard_audio_sink:monitor_FL sm57-carla:input_FL"
	"soundboard_audio_sink:monitor_FR sm57-carla:input_FR"
	"chat_audio_sink:monitor_FL $INTERFACE_OUTPUT_NODE:playback_FL"
	"chat_audio_sink:monitor_FR $INTERFACE_OUTPUT_NODE:playback_FR"
	"game_audio_sink:monitor_FL $INTERFACE_OUTPUT_NODE:playback_FL"
	"game_audio_sink:monitor_FR $INTERFACE_OUTPUT_NODE:playback_FR"
)

reset_notification_id() {
	NOTIF_ID=""
}

send_notification() {
    local icon="$1"
    local urgency="$2"
    local title="$3"
    local message="$4"
    local timeout="${5:-0}" # Default to 0 (system default) if not provided
    
    # Building the command base
    local cmd=(notify-send -a "$APP_NAME" -i "$icon" -u "$urgency")
    
    # Add timeout if specified
    if [ "$timeout" -gt 0 ]; then
        cmd+=("-t" "$timeout")
    fi

    # Try to replace existing notification if ID exists
    if [ -n "$NOTIF_ID" ]; then
        NOTIF_ID=$("${cmd[@]}" "$title" "$message" -r "$NOTIF_ID" -p 2>/dev/null) || \
        NOTIF_ID=$("${cmd[@]}" "$title" "$message" -p)
    else
        NOTIF_ID=$("${cmd[@]}" "$title" "$message" -p)
    fi
}

link_interface_nodes () {
	echo linking
	send_notification "dialog-information" "normal" "$INTERFACE_NAME" "Linking..." 2500

	for link in "${LINKS[@]}"; do
		pw-link $link 2>/dev/null
	done

	echo linked
	send_notification "emblem-success" "normal" "$INTERFACE_NAME" "Linked!" 2500
}

interface_is_connected () {
	if pw-cli info "$INTERFACE_OUTPUT_NODE" 2>&1 | grep -q "unknown global"; then
		return 1
	else
		return 0
	fi
}

notify_interface_plugged () {
	echo "device connected"
	send_notification "dialog-information" "normal" "$INTERFACE_NAME" "Device Connected!" 1000000
}

notify_interface_lost () {
	echo "device lost"
	reset_notification_id
	send_notification "dialog-error" "critical" "$INTERFACE_NAME" "Device lost!"
}

echo "monitoring for $INTERFACE_OUTPUT_NODE"

while true; do
	if interface_is_connected; then
		notify_interface_plugged
		sleep 0.25
		link_interface_nodes

		while interface_is_connected; do
			sleep 0.2
		done

		notify_interface_lost
	fi

	sleep 0.2
done