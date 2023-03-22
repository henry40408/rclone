#!/usr/bin/env bash

set -euo pipefail

rid="$(uuidgen)"

# Set the rclone source and destination paths
source_path="${SOURCE_PATH-}"
dest_path="${DEST_PATH-}"

healthchecks_url="${HEALTHCHECKS_URL-}"

curl -fsS -m 10 --retry 5 "${healthchecks_url}/start?rid=$rid"

# Sync the source and destination using rclone
m="$(rclone sync -P "$source_path" "$dest_path" 2>&1)"
curl -fsS -m 10 --retry 5 --data-raw "$m" "${healthchecks_url}/$??rid=$rid"
