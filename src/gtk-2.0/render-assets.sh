#! /bin/bash
set -ueo pipefail

# Make sure that parallel is GNU parallel and not moreutils.
# Otherwise, it fails silently. There's no smooth way to detect this.
if which parallel > /dev/null; then cmd=(parallel)
else cmd=(xargs -n1); fi

INDEX="assets.txt"
SRC_FILE="assets.svg"

_parallel() {
  which parallel && parallel $@ || (
    while read i; do
      $1 $i
    done
  )
}

GTK2_HIDPI=$(echo ${GTK2_HIDPI-False} | tr '[:upper:]' '[:lower:]')
if [[ ${GTK2_HIDPI} == "true" ]] ; then
  sed -i.bak -e '1s/width="200"/width="400"/' -e '1s/height="480"/height="960"/' $SRC_FILE
fi

cat $INDEX | _parallel ./render-asset.sh

if [[ ${GTK2_HIDPI} == "true" ]] ; then
  mv $SRC_FILE{.bak,}
fi

exit 0
