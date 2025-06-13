#!/bin/sh

set -e

# Avoid argument escape with Scaleway serverless jobs
RCLONE_CONFIG="$(eval echo ${RCLONE_CONFIG:-'/data/rclone.conf'})"
RCLONE_ARGS="$(eval echo ${RCLONE_ARGS:-'--checksum'})"
RCLONE_SOURCE="$(eval echo ${RCLONE_SOURCE:-'source'})"
RCLONE_DESTINATION="$(eval echo ${RCLONE_DESTINATION:-'destination'})"
HEARTBEAT_URL="$(eval echo ${HEARTBEAT_URL:-''})"

if [ "$#" -gt 1 ]; then
    echo "Error: Too many arguments. Only one argument is allowed."
    exit 1
fi

if [ ! -f "$RCLONE_CONFIG" ]; then
    mkdir -p /config/rclone/
    echo "$RCLONE_CONFIG" | base64 -d > /config/rclone/rclone.conf
    RCLONE_CONFIG="/config/rclone/rclone.conf"
fi

rclone $@ --config="$RCLONE_CONFIG" $RCLONE_ARGS "$RCLONE_SOURCE" "$RCLONE_DESTINATION"

if [ -z "$HEARTBEAT_URL" ]; then
    echo "HEARTBEAT_URL is empty"
    exit 1
fi

curl -sSL "$HEARTBEAT_URL"
