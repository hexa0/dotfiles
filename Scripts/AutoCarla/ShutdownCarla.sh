#!/bin/bash

########################################################################################################################
#                                                        Config                                                        #
########################################################################################################################


# since kdotool isn't an ubuntu package it has to be compiled manually, luckily this is rust so that makes it easier
# this must be manually set to the build location of kdotool
KDOTOOL="/home/hexa/Repositories/kdotool/target/debug/kdotool"

# target application to close
TARGET_WINDOW_TITLE="Carla - auto"


########################################################################################################################
#                                                        Logic                                                         #
########################################################################################################################


function KillExistingProcess() {
	local ExistingPID=$($KDOTOOL search "$TARGET_WINDOW_TITLE" getwindowpid)

	if [ "$ExistingPID" ]; then
		echo "exiting original process"
		kill $ExistingPID
	fi
}

KillExistingProcess

echo "finished"