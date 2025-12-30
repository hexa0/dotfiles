#!/bin/bash

cd $HOME/Scripts/E2x2/

local RESTART_FLAG=""

while true; do
    exec -a "e2x2-worker" bash worker.sh "$RESTART_FLAG" &
    WORKER_PID=$!

    wait $WORKER_PID

    RESTART_FLAG="restarted"
    echo "worker exited"
    sleep 0.5
done