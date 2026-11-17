#!/usr/bin/env sh
# Regenerate the STL files from the OpenSCAD source.
# Extra arguments are passed to OpenSCAD, e.g.:
#   ./build.sh -D car_hole_top_d=75.5 -D car_hole_bottom_d=72
set -e
cd "$(dirname "$0")"
mkdir -p stl
openscad -o stl/cupholder_polo_aw_nespresso.stl "$@" polo_aw_nespresso_cupholder.scad
openscad -o stl/fit_test.stl -D 'part="fit_test"' "$@" polo_aw_nespresso_cupholder.scad
echo "Done: stl/cupholder_polo_aw_nespresso.stl, stl/fit_test.stl"
