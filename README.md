My Intro to CI and CD for Deployment
======

### Introduction
This is one of the many repos used to display my progress on web dev.

This repo is moreso intended to guide me through deployment stuff rather than actually coding websites (because I already have those basic tools down).

Cd into `/basic_cicd` and:
* Make the virtual environment with `python3 -m venv .venv`
* `pip install requirements.txt`
* Run `./scripts/run.sh` to run the app.

The alternative to running the script would be:
* `source .venv/bin/activate`
* `flask --app __init__ run`

#### `restart.sh`

``` shell
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
```

Take the IP address and add '/hello' to the link as that's where the main page is.

This is very easy to run but there isn't really a reason to. See my [frontend](https://github.com/FutureNine972/leaderboard-basic-vue) repo for my leaderboard project (which also requires the [backend](https://github.com/FutureNine972/leaderboard-basic-flask)) for a much better Flask experience.