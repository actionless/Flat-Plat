#! /bin/bash
set -ueo pipefail

RSVG_CONVERT="/usr/bin/rsvg-convert"
OPTIPNG="/usr/bin/optipng"

if [[ "$1" == "dark" ]]; then
	SRC_FILE="assets-dark.svg"
	ASSETS_DIR="assets-dark"
else
	SRC_FILE="assets.svg"
	ASSETS_DIR="assets"
fi

i="$2"

if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo Rendering $ASSETS_DIR/$i.png
    $RSVG_CONVERT -i $i -o $ASSETS_DIR/$i.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
fi

exit 0
