#!/bin/bash
# ------------------------------------------
# Jenkins Backup Script - Upload to S3
# ------------------------------------------

# Variables
JENKINS_HOME="/var/lib/jenkins"
BACKUP_DIR="/tmp/jenkins_backup"
TIMESTAMP=$(date +%F-%H-%M)
BACKUP_FILE="jenkins-backup-$TIMESTAMP.tar.gz"
S3_BUCKET="s3://www.backups3jenkins"

# Create backup directory
mkdir -p $BACKUP_DIR

echo "🔹 Stopping Jenkins service..."
sudo systemctl stop jenkins

echo "🔹 Creating Jenkins backup..."
sudo tar -czf $BACKUP_DIR/$BACKUP_FILE -C $JENKINS_HOME .

echo "🔹 Starting Jenkins service..."
sudo systemctl start jenkins

echo "🔹 Uploading backup to S3..."
aws s3 cp $BACKUP_DIR/$BACKUP_FILE $S3_BUCKET/

echo "✅ Backup completed successfully: $BACKUP_FILE"
echo "✅ Uploaded to: $S3_BUCKET"

# (Optional) Clean up backups older than 7 days
find $BACKUP_DIR -type f -mtime +7 -delete
