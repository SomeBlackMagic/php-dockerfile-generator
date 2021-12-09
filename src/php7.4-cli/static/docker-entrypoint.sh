#!/usr/bin/env bash

set -e
set -u
set -o pipefail


if [[ $1 == "bash" ]]; then
  exec /bin/bash
  exit;
fi

###
### Globals
###

# Path to scripts to source
CONFIG_DIR="/docker-entrypoint.d"


###
### Source libs
###
init="$( find "${CONFIG_DIR}" -name '*.sh' -type f | sort -u )"
for f in ${init}; do
	# shellcheck disable=SC1090
	echo "running $f"
	. "${f}"
done


echo
echo 'Init process done. Ready for start up.'
echo


exec "${@}"