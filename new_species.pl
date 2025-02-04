#!/usr/bin/env bash

# this is a hacky way to run dockerized linux application locally

realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

timezone() {
    if [ "$(uname)" == "Darwin" ]; then
        TZ=$(readlink /etc/localtime | sed 's#/var/db/timezone/zoneinfo/##')
    else
        TZ=$(readlink /etc/timezone)
    fi
    echo $TZ
}


# Only allocate tty if one is detected. See - https://stackoverflow.com/questions/911168
if [[ -t 0 ]]; then IT+=(-i); fi
if [[ -t 1 ]]; then IT+=(-t); fi

WORKDIR="$(realpath .)"
MOUNT="type=bind,source=${WORKDIR},target=${WORKDIR}"
TZ="$(timezone)"

# check all arguments for paths to use as mount points
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
all_mounts=$($SCRIPTPATH/dockerized-parser.py "$WORKDIR" "$@")

exec docker run --rm "${IT[@]}" -e TZ="${TZ}" --workdir "${WORKDIR}" $all_mounts  augustus new_species.pl "$@"
