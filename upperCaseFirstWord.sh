# https://unix.stackexchange.com/questions/193064/convert-all-first-character-in-an-email-id-to-upper-case-in-bash/193078#193078

EMAIL_ADDRESS=this.is.a.very-long_email.id@domainname.com
# convert email address into words
# - remove suffix domain
# - use IFS to split long string into words with ' ' as seperator
# - convert string of words into array WORDS
# - uppercase the first character
WORDS=( $(IFS=._-; printf '%s ' ${EMAIL_ADDRESS%@*}) )
echo "${WORDS[@]^}"

sed 's/@.*//; s/[-_.]/ /g; s/\<./\U&/g' <<END
${EMAIL_ADDRESS}
END
