#!/bin/bash

DELUSER="alcides_ideias3"
DELPASS="tkhxbq"

NOW=$(date +"%Y-%m-%d")

# Delicious

DELBACKUP=$BACKROOT/delicious_$NOW.xml
touch $DELBACKUP
wget --output-document=$DELBACKUP https://$DELUSER:$DELPASS@api.del.icio.us/v1/posts/all
