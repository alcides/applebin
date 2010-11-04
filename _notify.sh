#!/bin/sh
#
#  Runs script, and prints a notification with growl
#  or libnotify when it finishes
#
# Written sometime in 2006, posted 2007/08
# Part of Susie since May 2008.
#
# With Tips from Ranger Rick, Tim Bunce and Ruben Fonseca
#
# Pedro Melo <melo@simplicidade.org>
#
 
if [ -z "$1" ] ; then
  cat <<USAGE
Usage: x-notify cmd
 
Executes 'cmd' and send a notification via Growl or libnotify
when the command ends.
 
USAGE
  exit 1
fi
 
# Run the command, including arguments with spaces
"$@"
status=$?
 
# decide which status to use
if [ "$status" == "0" ] ; then
    result="completed"
else
    result="FAILED ($status)"
fi
 
# decide which notifier we have
env growlnotify -h > /dev/null 2> /dev/null
has_growl=$?
env notify-send -? > /dev/null 2> /dev/null
has_libnotify=$?
 
# notify the user, growl or libnotify
if [ "$has_growl" == "0" ] ; then
    growlnotify -m "Script '$@' $result" -s "Background script notification" &
elif [ "$has_libnotify" == "0" ] ; then
    notify-send "Script '$@' $result" "Background script notification" &
else
  echo no notitifer...
fi
 
# exit with the original status
exit $status