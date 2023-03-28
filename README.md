# rclone Docker Image

![rclone Version](https://img.shields.io/badge/rclone-v1.62.1-blue)
![Latest Release](https://img.shields.io/github/v/release/henry40408/rclone?label=Latest%20Release)
[![Latest Build](https://img.shields.io/github/actions/workflow/status/henry40408/rclone/build.yml?branch=main&label=build&logo=docker&logoColor=white)](https://github.com/henry40408/rclone/actions/workflows/build-docker-image.yml)
[![Docker Image Supported Architectures](https://img.shields.io/badge/arch-amd64%20%7C%20arm64-blue?logo=docker&logoColor=white)](https://hub.docker.com/r/myusername/rclone)
[![License](https://img.shields.io/github/license/henry40408/rclone)](https://github.com/henry40408/rclone/blob/main/LICENSE)

This Docker image runs the `rclone sync` command to synchronize files between a source and destination location, and sends an HTTP request to a specified Healthchecks endpoint with the execution time and result of the sync operation.

## Getting Started

To use this image, you will need Docker installed on your system. You can then pull the pre-built Docker image from the GitHub Container Registry:

```
docker pull ghcr.io/henry40408/rclone:latest
```

This will download the latest tagged release of the `rclone` image.

Alternatively, you can pull a specific version of the image by specifying the tag. For example, to pull version `v1.62.1-1`:

```
docker pull ghcr.io/henry40408/rclone:v1.62.1-1
```

Note that in addition to tagged releases, this Docker image is also automatically built and published as a nightly image from pull requests. These images are tagged with `nightly`, such as `ghcr.io/henry40408/rclone:nightly`.

## Usage

To use the `rclone` Docker image, you can start a container using the `docker run` command and pass in the required environment variables:

```
docker run -v $PWD/rclone.conf:/config/rclone/rclone.conf \
  -e SOURCE_PATH="source:/path/to/source" \
  -e DEST_PATH="dest:/path/to/destination" \
  -e HEALTHCHECKS_URL="https://hc-ping.com/your_healthchecks_uuid" \
  ghcr.io/henry40408/rclone
```

The configuration file should be mounted as `/config/rclone/rclone.conf`, which is required by the `rclone/rclone` base image. This will synchronize files between the specified source and destination paths using `rclone sync`, and send an HTTP request to the specified Healthchecks endpoint with the execution time and result of the sync operation.

## Environment Variables

The following environment variables are supported:

| Variable | Description |
| -------- | ----------- |
| `SOURCE_PATH` | The source path to sync using `rclone`. |
| `DEST_PATH` | The destination path to sync using `rclone`. |
| `HEALTHCHECKS_URL` | The URL of the Healthchecks endpoint to send the ping. |

You can set these environment variables when starting the container using the `-e` flag. For example:

```
docker run -e SOURCE_PATH="source:/path/to/source" -e DEST_PATH="dest:/path/to/destination" -e HEALTHCHECKS_URL="https://hc-ping.com/your_healthchecks_uuid" ghcr.io/henry40408/rclone
```

Note: Replace `source:/path/to/source` and `dest:/path/to/destination` with your own source and destination paths, and replace `https://hc-ping.com/your_healthchecks_uuid` with your own Healthchecks URL.

## Result Upload

The output of the `rclone sync` command will be captured and uploaded to Healthchecks along with the execution time. If the command completes successfully, the result will be "SUCCESS". If an error occurs, the result will be "ERROR" and the error message will be included in the Healthchecks ping.

## License

This Docker image is distributed under the MIT license. You can find a copy of the license in the `LICENSE` file.
