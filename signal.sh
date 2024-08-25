#!/bin/bash

_term() {
    echo "[BASH] Caught SIGINT signal!"
    kill -INT "$child" 2>/dev/null
}

trap _term SIGINT

echo "[BASH] Start daemon with trapping INTERRUPT...";
python3 signals.py &
jobs -n
# https://unix.stackexchange.com/questions/146756/forward-sigterm-to-child-in-bash
# Normally, bash will ignore any signals while a child process is executing.
# Starting the server with & will background it into the shell's job control
# system, with $! holding the server's PID (to be used with wait and kill).
#
# Calling wait will then wait for the job with the specified PID (the server)
# to finish, or for any signals to be fired.
child=$!
wait "$child"

jobs -n