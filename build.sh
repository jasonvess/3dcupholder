#!/usr/bin/env sh
# Regenerate the STL files from the OpenSCAD source.
# Extra arguments are passed to OpenSCAD, e.g.:
#   ./build.sh -D car_hole_top_d=75.5 -D car_hole_bottom_d=72
set -e
cd "$(dirname "$0")"
mkdir -p stl
SRC=polo_aw_nespresso_cupholder.scad
# V2: octagonal plug (recommended)
openscad -o stl/cupholder_polo_aw_nespresso_v2_octagon.stl "$@" "$SRC"
openscad -o stl/fit_test_v2_octagon.stl -D 'part="fit_test"' "$@" "$SRC"
# V1: round plug
openscad -o stl/cupholder_polo_aw_nespresso.stl -D 'plug_shape="round"' "$@" "$SRC"
openscad -o stl/fit_test.stl -D 'part="fit_test"' -D 'plug_shape="round"' "$@" "$SRC"
echo "Done: V2 (octagon) and V1 (round) STLs in stl/"
