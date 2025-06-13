#!/bin/sh

set -e

RCLONE_CONFIG="${RCLONE_CONFIG:-'/data/rclone.conf'}"
RCLONE_ARGS="${RCLONE_ARGS:-'--checksum'}"
RCLONE_SOURCE="${RCLONE_SOURCE:-'source'}"
RCLONE_DESTINATION="${RCLONE_DESTINATION:-'destination'}"
HEARTBEAT_URL="${HEARTBEAT_URL:-''}"

if [ "$#" -gt 1 ]; then
    echo "Error: Too many arguments. Only one argument is allowed."
    exit 1
fi

if [ ! -f "$RCLONE_CONFIG" ]; then
    mkdir -p /config/rclone/
    echo "$RCLONE_CONFIG" | base64 -d > /config/rclone/rclone.conf
    RCLONE_CONFIG="/config/rclone/rclone.conf"
fi

rclone "$1" --config="$RCLONE_CONFIG" $RCLONE_ARGS "$RCLONE_SOURCE" "$RCLONE_DESTINATION"

if [ -z "$HEARTBEAT_URL" ]; then
    echo "HEARTBEAT_URL is empty"
    exit 1
fi

curl -sSL "$HEARTBEAT_URL"
