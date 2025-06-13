FROM rclone/rclone:latest

RUN apk add --no-cache curl

COPY --chmod=0755 ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
