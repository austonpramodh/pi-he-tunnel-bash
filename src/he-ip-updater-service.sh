#!/bin/sh

set -e

. /etc/pi-he-tunnel-bash/config.cfg

echo "UPDATEURL=$UPDATEURL"
echo "UPDATE_INTERVAL=$UPDATE_INTERVAL"

update_ip() {
  response="$(curl -s $UPDATEURL)"
  echo "$(date +%d.%m.%Y-%H:%M:%S): $response"
}

while true; do
  update_ip
  sleep ${UPDATE_INTERVAL}
done
