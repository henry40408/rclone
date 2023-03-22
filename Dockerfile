FROM rclone/rclone:1.62.2

RUN apk add --no-cache bash curl uuidgen

WORKDIR /app

COPY run.sh run.sh

ENV SOURCE_PATH=""
ENV DEST_PATH=""
ENV HEALTHCHECKS_URL=""

CMD ["./run.sh"]
