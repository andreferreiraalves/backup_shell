#!/bin/bash

data=$(date '+%Y-%m-%d')
logfile="/home/andre/logs/backup_$data.log"
dumpsql="/home/andre/temp/dump_$(date +%Y-%m-%d"_"%H_%M_%S).sql"

log() {
	mensagem="$(date '+%Y-%m-%d %H:%M:%S') - $1"
	echo "$mensagem" | tee -a "$logfile"
}

###

log "removing old files"
rm /home/andre/temp/*.sql

log "backup postgres affine"
docker exec -t postgres pg_dumpall -c -U affine > $dumpsql

if [ $? -eq 0 ]; then
	log "creating tar.gz file"
	tar -cvzf /mnt/backup/teste/$data.tar.gz $dumpsql /mnt/volume/affine/storage/ /mnt/volume/nextcloud/data/admin/files

	if [ $? -eq 0 ]; then
		log "done, file created /mnt/backup/teste/$data.tar.gz"
	else
		log "ERROR ON CREATING TAR.GZ FILE"
	fi
else
	log "ERROR ON BACKUP POSTGRES"
fi
