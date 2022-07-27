#!/usr/bin/env bash
#!/bin/bash

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------

#	Titulo del mapa
	title=EJ1.2_Hemisferico_sh
	echo $title

#	Proyecciones acimutales requieren 3 parametros + 1 opcional (lon0/lat0[/horizon]/width
#	L(a)mbert Equal Area; (S)tereographic; Orto(g)rafica; (E)quidistante
	PROJ=S-65/-30/90/15c

#	Region geografica del mapa (W/E/S/N) d=-180/180/-90/90 g=0/360/-90/90
	REGION=d

# 	Nombre archivo de salida
	OUT=$title.ps

#	Parametros por Defecto
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion GMT
	gmt set GMT_VERBOSE w

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Abrir archivo de salida (ps)
	gmt psxy -R$REGION -J$PROJ -T -K -P > $OUT

#	Pintar areas secas (-G). Resolucion datos full (-Df)
	gmt pscoast -R -J -O -K -Df -G200 >> $OUT

#	Dibujar Antartida_Argentina. Los meridianos 74° Oeste y 25° Oeste y el paralelo 60° Sur y el Polo Sur.
#	Dibujar archivo con borde (-Wpen), Relleno (-Gfill), Lineas siguen meridianos (-Am), Cerrar polígonos (-L)
	gmt psxy -R -J -O -K -L -Am -Grosybrown2 -W0.25 >> $OUT << EOF
	-74 -60
	-74 -90
	-25 -60
EOF

#	Pintar areas húmedas: Oceanos (-S) y Lagos y Rios (-C)
#	gmt pscoast -R -J -O -K -Sdodgerblue2 >> $OUT
	gmt pscoast -R -J -O -K -Sdodgerblue2 -C200 >> $OUT
#	gmt pscoast -R -J -O -K -Swhite -C200 >> $OUT

#	Dibujar Paises (1 paises, 2 estados/provincias en America, 3 limite maritimo)
	gmt pscoast -R -J -O -K -N1/0.2,- >> $OUT

#	Dibujar Linea de Costa
	gmt pscoast -R -J -O -K -Df -W1/ >> $OUT

#	Resaltar paises DCW (-E). Codigos ISO 3166-1 alph-2. (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur). Pintar de color (+g), Dibujar borde (+p). 
	gmt pscoast -R -J -O -K -EAR,FK,GS+grosybrown2+p >> $OUT
	
#	Resaltar provincias DCW (-E). Codigos ISO 3166-2:AR (X: Cordoba, L: La Pampa, J: San Juan).
#	gmt pscoast -R -J -O -K -EAR.X,AR.L,AR.J+gorange+p >> $OUT

#	Dibujar marco del mapa 
	gmt psbasemap -R -J -O -K -Bg >> $OUT

#	Dibujar paralelos principales y meridiano de Greenwich a partir del archivo paralelos.txt -Am (lineas siguen meridianos)
	gmt psxy -R -J -O -K 'Paralelos.txt' -Ap -W0.50,.- >> $OUT

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> $OUT

#	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert $OUT -Tg -A -Z

#	Borrar archivos tempostales
	rm gmt.*