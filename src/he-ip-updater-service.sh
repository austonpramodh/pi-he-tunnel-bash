#!/bin/sh

set -e

. /etc/pi-he-tunnel-bash/config.cfg

echo "UPDATEURL=$UPDATEURL"
echo "UPDATE_INTERVAL=$UPDATE_INTERVAL"

last_ip=""

update_ip() {
  local current_ip=$(curl -s https://api.ipify.org)

  if [ "$current_ip" = "$last_ip" ]; then
    echo "$(date +%d.%m.%Y-%H:%M:%S): IP Unchanged $current_ip"
  else
    local response="$(curl -s $UPDATEURL)"
    echo "$(date +%d.%m.%Y-%H:%M:%S): $response"
    last_ip="$current_ip"
  fi
}

while true; do
  update_ip
  sleep ${UPDATE_INTERVAL}
done
