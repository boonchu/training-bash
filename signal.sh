#!/bin/bash

# set -o errexit -o errtrace
set -eE

__term__() {
  echo "[BASH] Caught SIGINT signal!"
  kill -INT "$child" 2>/dev/null
}

__error_handling__() {
  echo "[BASH] Caught ERR signal!"
  echo >&2 "Error - exited with status $? at line $LINENO:";
  pr -tn $0 | tail -n+$((LINENO - 3)) | head -n7
}

trap '__term__' SIGINT
# https://stackoverflow.com/questions/35800082/how-to-trap-err-when-using-set-e-in-bash
trap '__error_handling__ $? $LINENO' ERR

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
