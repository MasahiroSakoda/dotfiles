#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -eo pipefail

DOWNLOAD_PATH="$HOME/Downloads/YouTube/Audio"
DOWNLOADER_OPTS="--external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M'"
AUDIO_OPTS="--extract-audio --audio-format mp3 --audio-quiality 128k"

cd $DOWNLOAD_PATH
$(command -v yt-dlp) -civ $DOWNLOADER_OPTS $AUDIO_OPTS -o "%(title)s.%(ext)s" $1
