if [ -z "$1" ] ; then
  cat <<USAGE
Usage: _m cmd
 
Executes 'cmd' and sends an email to notify the process has ended.
 
USAGE
  exit 1
fi
 
# Run the command, including arguments with spaces
"$@"
curl http://alcidesfonseca.com/mail.php?result=$?\&machine=`uname -n`