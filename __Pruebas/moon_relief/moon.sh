#!/bin/bash -e

gmt set GMT_DATA_SERVER=test
gmt begin moon_relief png
	gmt grdimage @moon_relief_06m -I -Bf -Cmoon_relief.cpt
	gmt colorbar -Ba2000
gmt end
