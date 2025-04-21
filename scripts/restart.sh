#!/usr/bin/env bash

# For GitHub actions to restart the server when deploy new code

FILE_NAME="./flask.pid"

if [ -f "$FILE_NAME" ]; then
    echo "Found existing process, killing now"

    # Try to kill last started process, if doesn't exist then shut up
    kill $(cat "$FILE_NAME") || true

    rm "$FILE_NAME"

    echo "Cleanup complete"
fi

echo "Starting new process"

nohup flask --app __init__ run > flask.log 2>&1 &
echo $! > $FILE_NAME

echo "Process started successfully"
