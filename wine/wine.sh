#!/usr/bin/env bash

set -e

wineuser=wineuser

if [[ "$(docker images -q wine-container 2> /dev/null)" == "" ]]; then
  docker build -t wine-container -f Wine.dockerfile .
fi

docker run -t -d \
  --name wine \
  --env="DISPLAY" \
  --volume="${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  --volume="${HOME}/tools/win/:/home/${wineuser}/win/:rw" \
  -v "/dev/bus/usb:/dev/bus/usb" \
  -w "/home/${wineuser}/" \
  wine-container "/bin/bash"

