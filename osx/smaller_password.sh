# This script changes the miminum requires password (needed after mojave)

FILE1=~/Desktop/file.plist
FILE2=~/Desktop/file2.plist
pwpolicy getaccountpolicies > $FILE1
tail -n +2 "$FILE1" > $FILE2
plutil -replace policyCategoryPasswordContent.0.policyContent -string "policyAttributePassword matches '^$|.{1,}+'" "$FILE2"
pwpolicy setaccountpolicies "$FILE2"
passwd
rm "$FILE1"
rm "$FILE2"
