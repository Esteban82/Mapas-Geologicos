#!/bin/bash -e
# remote_map_check.sh - Make global test maps for both 05m and 06m resolutions
#
# usage: remote_map_check
#
# Loops over all recipies and makes global maps of them for the two resolutions
# This checks that the tiled and single grid versions are similar
#

gmt set GMT_DATA_SERVER=test
gmt begin check_moon_relief png
	gmt subplot begin 2x1 -Fs15c/12c -Rg -JH15c -A -T"Moon Relief"
	gmt subplot set 0 -A"-9200/10800"
	gmt makecpt -Cgray,white -T-9200/10800 #> moon_relief.cpt
	gmt grdimage @moon_relief_06m -Rg -I
	gmt colorbar -DJRL
	gmt subplot set 1 -A"5m"
	gmt makecpt -Cblack,white -T-9200/10800 #> moon_relief.cpt
	gmt grdimage @moon_relief_06m -Rg -I
	gmt colorbar -DJRL
	gmt subplot end
gmt end #show
