#!/usr/bin/env bash

declare -A numbers

numbers=([one]=1 [two]=2 [three]=3)
echo "1+2 is $(( ${numbers[one]} + ${numbers[two]} ))"

# bitwise XOR ^
result=$(( ${numbers[three]}^${numbers[two]} ))
echo "3 XOR 2 is $result"

declare -A fruits colors
colors=([red]='#FF0000' [green]='#00FF00' [blue]='#0000FF')
fruits=([apple]=red [banana]=yellow [orange]=orange)
[[ ${colors[@]} == ${frults[@]} ]] && echo 'identical' || echo 'two arrays are diffs'
echo "green has color code ${colors[green]}"

for key in ${!fruits[@]}; do
    echo "$key: ${fruits[$key]}"
done

# '<<<' ~ here string `sed 's/a/b/g' <<< "aaa"`
while read -r key value; do 
    echo "$key: $value"
done <<< "${!colors[@]} ${colors[@]}"
