#!/bin/bash
# Backup automation script

SOURCE_DIR=$1
BACKUP_DIR=$2

LOG_FILE_NAME=$3
LOG_FILE_PATH="/home/drake21/syslogs"
LOG_FILE="$LOG_FILE_PATH/$LOG_FILE_NAME.log"

find "$LOG_FILE_PATH" -type f -name "*.log" -mmin +5 -exec rm -f {} \;

echo "Accepting arguments: $SOURCE_DIR and $BACKUP_DIR" >> $LOG_FILE

tar -czf "$BACKUP_DIR/backup_$(date +%F_%H-%M).tar.gz" "$SOURCE_DIR"

echo "tar -czf $BACKUP_DIR/backup_$(date +%F_%H-%M).tar.gz $SOURCE_DIR" >> $LOG_FILE

if [ $? -ne 0 ]; then
	echo "❌ Error!"
	echo "⚠️  Error handling!" >> $LOG_FILE
	exit 1
fi

echo -e "\e[32mBackup successful!\e[0m"
