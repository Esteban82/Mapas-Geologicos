#!/bin/bash -e

gmt set GMT_DATA_SERVER=test
gmt begin moon_relief png
	gmt makecpt -Cgray -T-9200/10800
	gmt grdimage @moon_relief_06m -I -C -Bf
	#gmt colorbar -Ba2 -W0.001

	gmt makecpt -Cgray10,white -T-9200/10800 -I
	gmt grdimage @moon_relief_06m -I -C -Bf -Yh
	#gmt colorbar -Ba2 -W0.001

	gmt makecpt -C56/2/123,215/255/255,52/31/31 -T-9000/0/10000
	#-T-9000,-8000,-7000,-5000,0,2000,4000,6000,7000,8000,10000
	gmt grdimage @moon_relief_06m -I -C -Bf -Yh
	#gmt colorbar -Ba2 -W0.001

	#gmt makecpt -Cgray15,white -T-9200/10800 -I
	#gmt grdimage @moon_relief_06m -I -C -Bf -Yh
gmt end

: ' 
#Elevation_m Red Green Blue
-9000.0 56 2 123
-8000.0 0 0 89
-7000.0 0 94 187
-5000.0 60 157 255
0.0 215 255 255
2000.0 255 255 255
4000.0 192 192 192
6000.0 128 128 128
7000.0 83 83 83
8000.0 51 51 51
10000.0 52 31 31
' 