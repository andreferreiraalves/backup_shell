#!/usr/bin/env sh

# Diretório de backup
backup_path="/home/andre/Pictures/Screenshots"

# Diretório de destino
external_storage="/media/andre/arquivos/temp"

# Diretório-arquivo de log
log_path="/var/log/daily-backup.log"

date_format=$(date "+%d-%m-%Y")
final_archive="backup-$date_format.tar.gz"


# if !mountpoint -q -- $external_storage; then
#   printf "[$date_format] Caminho não encontrado em $external_storage\n" >> $log_path
#   exit 1
# fi


if tar -czSpf "$external_storage/$final_archive" "$backup_path"; then
  printf "[$date_format] backup com sucesso\n" >> $log_path
else
  printf "[$date_format] erro no backup\n" >> $log_path
fi
