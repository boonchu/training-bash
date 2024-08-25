# https://unix.stackexchange.com/questions/148181/how-can-i-reverse-the-first-part-of-a-sentence/148188#148188
# read two strings and use `rev` to reverse the first param

echo '12,222,331 "contains the messages"' | { read -r first rest; printf '%s %s\n' "$(rev <<< "$first")" "$rest"; }

echo '12,222,331 "contains the messages"' | sed 's/^/ /;:1; s/^\([^ ]*\) \([^ ]\)/\2\1 /;t1; s/ //'

# preq: sudo apt-get install moreutils -> `pee`
echo -n '12,222,331 "contains the messages"' | pee "cut -d ' ' -f 1 | rev" "cut -d ' ' -f 2-" | tr '\n' ' '; echo

(
  set -f; IFS=,\
  set -- ${0+'12,222,331 "contains the messages"'}
  while [ -n "${2+?}" ]; do
    r="$1,$r"
    shift ;
  done
  echo "${r%,} $1"
)
