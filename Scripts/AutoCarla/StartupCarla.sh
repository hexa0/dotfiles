#!/bin/bash

########################################################################################################################
#                                                        Config                                                        #
########################################################################################################################


# since kdotool isn't an ubuntu package it has to be compiled manually, luckily this is rust so that makes it easier
# this must be manually set to the build location of kdotool
KDOTOOL="/home/hexa/Repositories/kdotool/target/debug/kdotool"

# what command to run to initate the process
LAUNCH_PROCESS="pw-jack carla \"/home/hexa/Scripts/Carla Projects/auto\""
# target application to move and which virtual desktop to set it to
TARGET_WINDOW_TITLE="Carla - auto"
TARGET_VIRTUAL_DESKTOP=4
# how often to search for the window id
KDO_SEARCH_RATE=0.1

# wine build, this must be at the start or else the subshell that runs carla won't see this variable and it will crash
export WINELOADER="$HOME/.local/share/wine-yabridge/9.21-staging/bin/wine"


########################################################################################################################
#                                                        Logic                                                         #
########################################################################################################################


function SearchForWindowTitle() {
	local WindowID=""
	# The loop continues until a window ID is found.
	while [[ -z "$WindowID" ]]; do
		# The command's output is captured and stored in the 'WindowID' variable.
		WindowID=$("$KDOTOOL" search --limit 1 "$TARGET_WINDOW_TITLE")
		# Check if the command was successful. `kdotool search` returns an empty string
		# on failure, which is what we are looking for with the '-z' flag.
		if [[ -z "$WindowID" ]]; then
			sleep $KDO_SEARCH_RATE
		fi
	done
	# The function returns the found window ID.
	echo "$WindowID"
}

function KillExistingProcess() {
	local ExistingPID=$($KDOTOOL search "$TARGET_WINDOW_TITLE" getwindowpid)

	if [ "$ExistingPID" ]; then
		echo "exiting original process"
		kill $ExistingPID
		sleep 1
	fi
}

KillExistingProcess

echo "starting process in background"
eval "$LAUNCH_PROCESS > /dev/null &"

echo "wait for \"$TARGET_WINDOW_TITLE\""
FoundWindowId=$(SearchForWindowTitle)
echo "got $FoundWindowId"


echo "set_desktop_for_window"
"$KDOTOOL" set_desktop_for_window "$FoundWindowId" $TARGET_VIRTUAL_DESKTOP
"$KDOTOOL" windowminimize "$FoundWindowId"
echo "finished"