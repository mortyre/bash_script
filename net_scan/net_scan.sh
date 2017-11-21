#!/bin/bash
#for i in {65..126..1}; do echo "89.175.169.$i" >> servers.db; done

DIR=/opt/net_scan
MAIL='s.starkov@unact.ru'
cp $DIR/tmp_report.html $DIR/report.html
for host in `cat $DIR/servers.db`

	do
		nmap -Pn -p "*" -sT -sU -oG file.og  $host
		NAME_DNS=$( cat $DIR/file.og | grep -i ports | awk '{print $3}' )
		sed -i "s/name/$host $NAME_DNS/" $DIR/report.html
		PORTS=$( cat $DIR/file.og | grep -i ports | awk '{$1=$2=$3=$4=""; print $0}' | sed "s/,/<br>/g" | sed "s/\/\/\///g" | sed "s/\/\//-/g" | sed "s/\//-/g" )
		sed  -i 's/ports/'"${PORTS}"'/g' $DIR/report.html
		cat $DIR/tmp_report.html >> $DIR/report.html
	done

mutt -s "Ports scan report" -e "set content_type=text/html" $MAIL < $DIR/report.html
