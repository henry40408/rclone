#!/usr/bin/env bash

set -euo pipefail

rid="$(uuidgen)"

# Set the rclone source and destination paths
source_path="${SOURCE_PATH-}"
dest_path="${DEST_PATH-}"

healthchecks_url="${HEALTHCHECKS_URL-}"

curl -fsS -m 10 --retry 5 "${healthchecks_url}/start?rid=$rid"

# Sync the source and destination using rclone
rclone sync "$source_path" "$dest_path"
curl -fsS -m 10 --retry 5 "${healthchecks_url}/$??rid=$rid"
