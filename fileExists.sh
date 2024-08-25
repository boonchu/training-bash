set -eE 

__error_handling__() {
  echo "[BASH] Caught ERR signal!"
  echo >&2 "[BASH] Error - exited with status $? at line $LINENO:";
  pr -tn $0 | tail -n+$((LINENO - 3)) | head -n7
}
trap '__error_handling__ $? $LINENO' ERR

# https://unix.stackexchange.com/questions/257986/what-is-the-value-of-1/257991#257991
fileExists() {
  cat -- "$@"
}
fileExists input.txt

# https://unix.stackexchange.com/questions/33150/check-if-filename-exist-from-inline-command/33153#33153
[ -f "$(cat input.txt | grep FILE | sed 's/^.*"\(.*\)".*$/\1/')" ] && echo "file exist" || echo "file does not exist"
