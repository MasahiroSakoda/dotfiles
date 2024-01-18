#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -eo pipefail

DOWNLOAD_PATH="$HOME/Downloads/YouTube/Videos"
DOWNLOADER_OPTS="--external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M'"
FORMAT_OPTS="bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
CODEC_OPTS="vcodec:h264"

cd "$DOWNLOAD_PATH"
$(command -v yt-dlp) -civ "$DOWNLOADER_OPTS" -f "$FORMAT_OPTS" -S "$CODEC_OPTS" -o "%(title)s.%(ext)s" $1
