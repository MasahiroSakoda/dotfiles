#!/usr/bin/env bash
set -e
. bin/echo.sh

# Network
## Acclerate network with Google Public DNS
## networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8
## Acclerate network with Cloudflare DNS
networksetup -setdnsservers Wi-Fi 2606:4700:4700::1111 2606:4700:4700::1001 1.1.1.1 1.0.0.1

# Restart
sudo shutdown -r now
