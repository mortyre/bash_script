#!/bin/bash
DIR=/opt/test_port
HOST=connect.unact.ru
PORT=443
DATE=`date +"%d.%m"`
TIME=`date +"%H:%M"`

if nc -w 10 -z $HOST $PORT
then
        echo "$DATE $TIME Port ${PORT} is up" >> $DIR/log
else
        echo "Port ${PORT} is down" >> $DIR/log
fi
