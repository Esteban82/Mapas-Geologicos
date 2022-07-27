#!/bin/bash

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=EJ1.4_MapaPolitico_Sudamerica
	echo %title%

#	Region: Sudamérica
	REGION=-85/-33/-58/15

#	Proyeccion Conica. (lon0/lat0/lat1/lat2/width) Proyeccion Albers (B); Lambert (L): Equidistant (D).
#	PROJ=D-60/-30/-40/0/15c
	PROJ=B-60/-30/-40/0/15c

# 	Nombre archivo de salida
	OUT=$title.ps

#	Parametros por Defecto
#	-----------------------------------------------------------------------------------------------------------

#	Sub-seccion GMT
	gmtset GMT_VERBOSE 2

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Abrir archivo de salida (ps)
	gmt psxy -R$REGION -J$PROJ -T -K -P > $OUT

#	Resaltar paises DCW (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur y Sandwich del Sur, CO: Colombia)
	gmt pscoast -R -J -O -K -EAR,FK,GS+grosybrown2+p >> $OUT

#	Pintar areas húmedas: Oceanos (-S) y Lagos (-Cl/)f
	color=117/197/240
	gmt pscoast -R -J -O -K -Df -Sdodgerblue2 -Cl/$color >> $OUT

#	Dibujar Bordes Administrativos. N1: paises. N2: Provincias, Estados, etc. N3: limites marítimos (Nborder[/pen])
	gmt pscoast -R -J -O -K -Df -N1/0.75 >> $OUT
	gmt pscoast -R -J -O -K -Df -N2/0.25,-. >> $OUT

#	Dibujar Linea de Costa (level/, where level is 1-4 and represent coastline, lakeshore, island-in-lake shore, and lake-in-island-in-lake shore)
	gmt pscoast -R -J -O -K -Df -W1/0.25 >> $OUT

#	Dibujar rios -Iriver[/pen] 
#	0 = Double-lined rivers (river-lakes)
#	1 = Permanent major rivers
#	2 = Additional major rivers
#	3 = Additional rivers
#	4 = Minor rivers
	gmt pscoast -R -J -K -O -Df -I0/thin,$color >> $OUT
	gmt pscoast -R -J -K -O -Df -I1/thinner,$color >> $OUT
	gmt pscoast -R -J -K -O -Df -I2/thinner,$color,- >> $OUT
	gmt pscoast -R -J -K -O -Df -I3/thinnest,$color,-... >> $OUT
	gmt pscoast -R -J -K -O -Df -I4/thinnest,$color,4_1:0p >> $OUT

#	Dibujar frame
	gmt psbasemap -R -J -O -K -Baf >> $OUT

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> $OUT

#	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert $OUT -Tg -A

	rm temp_*

#	Ejercicios Sugeridos:
#	1. Modificar REGION para que abarque a Europa.
#	2. Modificar el color de los rios (variable %color%).
#	3. Modificar las lineas de os rios (ancho, estilo de linea).
