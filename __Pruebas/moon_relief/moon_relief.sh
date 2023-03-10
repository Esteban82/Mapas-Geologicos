#!/bin/bash -e

gmt set GMT_DATA_SERVER=test
gmt begin moon_relief png
	#gmt makecpt -Cgray -T-9200/10800
	#gmt grdimage @moon_relief_06m -I -C -Bf
	#gmt colorbar -Ba2 -W0.001

	#gmt makecpt -Cgray10,white -T-9200/10800 -I
	#gmt grdimage @moon_relief_06m -I -C -Bf -Yh
	#gmt colorbar -Ba2 -W0.001

	#gmt makecpt -C56/2/123,215/255/255,52/31/31 -T-9000/0/10000
	#gmt grdimage @moon_relief_06m -I -C -Bf -Yh
	#gmt colorbar -Ba2 -W0.001

	#gmt makecpt -Cgray15,white -T-9200/10800 -I
	gmt grdimage @moon_relief_10m -I -Cmoon_relief.cpt -Bf
	gmt colorbar
gmt end
