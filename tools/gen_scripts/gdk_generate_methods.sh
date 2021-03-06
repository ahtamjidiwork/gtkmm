#!/bin/bash

# Note that JHBUILD_SOURCES should be defined to contain the path to the root
# of the jhbuild sources. The script assumes that it resides in the
# tools/gen_scripts/ directory and the defs file will be placed in gdk/src.

if [ -z "$JHBUILD_SOURCES" ]; then
  echo -e "JHBUILD_SOURCES must contain the path to the jhbuild sources."
  exit 1;
fi

PREFIX="$JHBUILD_SOURCES"
ROOT_DIR="$(dirname "$0")/../.."
OUT_DIR="$ROOT_DIR/gdk/src"

shopt -s extglob # Enable extended pattern matching
shopt -s nullglob # Skip a filename pattern that matches no file
H2DEF_PY="$JHBUILD_SOURCES/glibmm/tools/defs_gen/h2def.py"
# Process files whose names end with .h, but not with private.h.
# Exclude gtk+/gdk/gdkinternals.h.
$H2DEF_PY "$PREFIX"/gtk+/gdk/!(*private|gdkinternals).h "$PREFIX"/gtk+/gdk/deprecated/!(*private).h \
          "$PREFIX"/gtk+/build/gdk/*.h > "$OUT_DIR"/gdk_methods.defs
$H2DEF_PY "$PREFIX"/gdk-pixbuf/gdk-pixbuf/gdk!(*private).h \
          "$PREFIX"/gdk-pixbuf/build/gdk-pixbuf/*.h > "$OUT_DIR"/gdk_pixbuf_methods.defs
