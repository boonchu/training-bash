#!/usr/bin/env bash

# exit immediately if any cmmd returns non-zero exit status
# set trap when see ERR
set -e
trap "Error detected!" EXIT

path_filter() {
    while read -r f; do   echo "file=${f}"; done < <(find /tmp)
}

outputs=$(path_filter)

# The [[ ]] construct supports the -z and -n operators, but it 
# does not require quoting the string.
[[ -n $outputs ]] && [[ $outputs == file* ]] && echo 'yes' || exit 1

# treat unset or null variables as an error and exist with a message.
set -u
echo "${not_defined}"
