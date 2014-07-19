#!/bin/sh
HOST=192.168.0.12
USER=tanyawolff
BKUPDIR=/Users/tanyawolff/backups

# testing ssh
ssh -q -o BatchMode=yes "$USER@$HOST" true
test=$?
[ $test -ne 0 ] && echo "ssh $USER@$HOST failed" && exit $test
ts=`date +%Y%m%d-%H%M`

# Copy the sqlite3 databases to HOST machine
echo "Copying to $HOST:${BKUPDIR}:"
for t in development production test
do
echo "${t}_${ts}.sqlite3"
scp /home/pi/blueboxes/db/${t}.sqlite3 $USER@$HOST:${BKUPDIR}/${t}_${ts}.sqlite3
done
