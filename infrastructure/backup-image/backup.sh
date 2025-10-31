#!/bin/sh

HOST="mysql-annuaire"
USER="root"
PASSWORD="root"
DATABASE="test"
TIMESTAMP=$(date +"%F-%H-%M-%S")
BACKUP_FILE="/backups/${DATABASE}-${TIMESTAMP}.sql"

mysqldump -h "$HOST" -u"$USER" -p"$PASSWORD" "$DATABASE" > "$BACKUP_FILE"
