#!/usr/bin/env bash
# -*-mode:sh-*- vim:ft=sh

set -eo pipefail

curl -sS -X POST \
        -F "url=$1" \
        -F "consumer_key=$POCKET_CONSUMER_KEY" \
        -F "access_token=$POCKET_ACCESS_TOKEN" \
        https://getpocket.com/v3/add \
        > /dev/null
