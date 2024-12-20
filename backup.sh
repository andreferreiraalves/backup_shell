#!/bin/bash

data=$(date '+%Y-%m-%d')
logfile="/home/andre/logs/backup_$data.log"
dumpsql="/home/andre/temp/dump_$(date +%Y-%m-%d"_"%H_%M_%S).sql"

log() {
	mensagem="$(date '+%Y-%m-%d %H:%M:%S') - $1"
	echo "$mensagem" | tee -a "$logfile"
}

###

if [ -e /home/andre/temp/*.sql ]; then
	log "removing old files"

	rm /home/andre/temp/*.sql
fi

docker exec -t postgres pg_dumpall -c -U postgres > "$dumpsql"

tar -cvzf "/mnt/backup/teste/$data.tar.gz" "$dumpsql" /mnt/volume/affine/storage/ /mnt/volume/nextcloud/data/admin/files