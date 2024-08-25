#!/bin/bash

# set -o errexit -o errtrace
set -eE

__term__() {
  if [[ $_child_pid ]]; then
    echo "[BASH] Caught SIGINT signal!"
    kill -INT "$child_pid" 2>/dev/null
  else
    _killed="yes" 
  fi
}

__error_handling__() {
  echo "[BASH] Caught ERR signal!"
  echo >&2 "Error - exited with status $? at line $LINENO:";
  pr -tn $0 | tail -n+$((LINENO - 3)) | head -n7
}

echo "[BASH] Start daemon with trapping INTERRUPT...";
unset _child_pid
unset _killed
trap '__term__' SIGINT

# https://stackoverflow.com/questions/35800082/how-to-trap-err-when-using-set-e-in-bash
# trap '__error_handling__ $? $LINENO' ERR

python3 signals.py &
jobs -n
# https://unix.stackexchange.com/questions/146756/forward-sigterm-to-child-in-bash
# Normally, bash will ignore any signals while a child process is executing.
# Starting the server with & will background it into the shell's job control
# system, with $! holding the server's PID (to be used with wait and kill).
#
# Calling wait will then wait for the job with the specified PID (the server)
# to finish, or for any signals to be fired.
_child_pid=$!
if [[ $_killed ]]; then
  kill -INT "$_child_pid" 2>/dev/null
fi
# https://veithen.io/2014/11/16/sigterm-propagation.html
wait "$_child_pid" 2>/dev/null
trap - SIGINT
wait "$_child_pid" 2>/dev/null

jobs -n
