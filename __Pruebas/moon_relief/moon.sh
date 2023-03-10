#!/bin/bash -e

gmt set GMT_DATA_SERVER=test
gmt begin moon_relief png
	gmt grdimage @moon_relief_06m -I -Bf -Cmoon_relief2.cpt
	gmt colorbar -Ba2000
	
	gmt grdimage @moon_relief_06m -I -Bf -Cmoon_relief3.cpt -Y10c
	gmt colorbar -Ba2000
gmt end
