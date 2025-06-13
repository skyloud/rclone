#!/bin/sh

set -e

rclone "$@"

if [ -z "$HEARTBEAT_URL" ]; then
    echo "HEARTBEAT_URL is empty"
    exit 1
fi

curl -sSL "$HEARTBEAT_URL"
