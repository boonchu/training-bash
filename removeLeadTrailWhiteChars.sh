message='    foo    \t     bar   '
echo -e $message | awk '{$1=$1};1'
# trim whitespaces from left and right
echo -e $message | sed -e 's/^[[:space:]]+//; s/[[:space:]]+$//'
