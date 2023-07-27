#!/usr/bin/env bash

set -ex
VERSION='2023.1.0'

docker run \
  --name scilab \
  --env="DISPLAY" \
  --device="/dev/dri" \
  --group-add video \
  -v "${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  -v "/usr/lib/dri:/usr/lib/dri:ro" \
  -v /etc/localtime:/etc/localtime:ro \
  -v "$HOME/run/scilab/:/opt/scilab/:rw" \
  -w "/opt/scilab/" \
  "braginxv/scilab:$VERSION" "/opt/scilab/"
