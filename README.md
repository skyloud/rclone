# rclone

A tool for managing files on cloud storage.

## Usage

```sh
docker run --rm -it -v $(pwd)/rclone.conf:/data/rclone.conf:ro \
    -e RCLONE_SOURCE=my-source \
    -e RCLONE_DESTINATION=my-destination \
    -e RCLONE_ARGS="--checksum --max-age 12h --delete-excluded" \
    skyloud/rclone sync
```

## Entrypoint Argument

| Argument  | Description                       |
|-----------|-----------------------------------|
| `command` | rclone command (e.g., copy, sync) |

## Environment Variables

| Variable             | Description                               |
|----------------------|-------------------------------------------|
| `RCLONE_CONFIG`      | Path to rclone config file or base64      |
| `RCLONE_SOURCE`      | Source location for rclone operation      |
| `RCLONE_DESTINATION` | Destination location for rclone operation |
| `RCLONE_ARGS`        | Additional arguments for rclone           |
| `HEARTBEAT_URL`      | URL for sending heartbeat status          |


## Example

```sh
RCLONE_CONFIG=/data/rclone.conf
RCLONE_SOURCE=my-source
RCLONE_DESTINATION=my-destination
RCLONE_ARGS='--checksum'
HEARTBEAT_URL=https://...
```

See [rclone documentation](https://rclone.org/docs/) for more details.
