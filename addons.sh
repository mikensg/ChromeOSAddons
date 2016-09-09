#!/bin/bash

# Check if being run as root
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
# Mount as read write
mount -o remount, rw /
cd /opt

# Download install files
echo "Downloading files..."
wget --no-check-certificate -O "data.tar" "https://drive.google.com/uc?export=download&id=0B4_CLg4Lq-3bZVljRkJLYmdtMk0"
echo "Download complete!"

# Extract files
echo "Extracting files..."
mkdir -p /opt/data
tar -xf data.tar -C /opt/data
echo "Done"

# Make folders
echo "Making folders"

mkdir -p /opt/google/chrome/pepper
mkdir -p /usr/lib/cromo
mkdir -p /usr/lib/mozilla/plugins

# Copy Flash files

echo "Installing Flash.... ARGH!!!"
cp /opt/data/libpepflashplayer.so /opt/google/chrome/pepper/ -f
cp /opt/data/manifest.json /opt/google/chrome/pepper/ -f
cp /opt/data/pepper-flash.info /opt/google/chrome/pepper/ -f

# Copy MP3 stuff

echo "Installing MP3 stuff"
cp /opt/data/libffmpegsumo.so /usr/lib/cromo/ -f
cp /opt/data/libffmpegsumo.so /usr/lib/mozilla/plugins/ -f

echo "Cleaning up..."
rm -rf /opt/data
rm /opt/data.tar

echo "Restarting..."
restart ui
