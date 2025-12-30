#!/bin/bash

ffplay $(dirname "$0")/snd_meow.wav -nodisp -autoexit -af "volume=0.2" > /dev/null 2>&1