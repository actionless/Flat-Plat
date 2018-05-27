#! /bin/bash
set -ueo pipefail

# Make sure that parallel is GNU parallel and not moreutils.
# Otherwise, it fails silently. There's no smooth way to detect this.
if which parallel > /dev/null; then cmd=(parallel)
else cmd=(xargs -n1); fi

INDEX="assets.txt"
SRC_FILE="assets.svg"
SRC_FILE_2="assets@2.svg"

_parallel() {
  which parallel && parallel $@ || (
    while read i; do
      $1 $i
    done
  )
}

sed -e '1s/width="400"/width="800"/' -e '1s/height="400"/height="800"/' $SRC_FILE > $SRC_FILE_2
cat $INDEX | _parallel ./render-asset.sh
rm $SRC_FILE_2

exit 0
