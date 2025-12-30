#!/bin/bash

ffplay $(dirname "$0")/pspBoot32FloatingPoint.wav -nodisp -autoexit -af "volume=0.2" > /dev/null 2>&1