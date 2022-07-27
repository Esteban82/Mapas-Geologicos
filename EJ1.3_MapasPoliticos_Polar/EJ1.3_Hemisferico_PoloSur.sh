#!/usr/bin/env bash

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=EJ1.3_Hemisferico_PoloSur
	echo %title%

#	Proyecciones acimutales requieren 3 parametros + 1 opcional (lon0/lat0[/horizon]/width
#	L(a)mbert Equal Area; (S)tereographic; Orto(g)rafica; (E)quidistante
#	PROJ=G-65/-30/15c
	PROJ=S-65/-90/15c

#	Region geografica del mapa (W/E/S/N) d=-180/180/-90/90 g=0/360/-90/90
#	REGION=d
	REGION=-180/180/-90/-60

# 	Nombre archivo de salida
	OUT=%title%.ps

#	Parametros por Defecto
#	-----------------------------------------------------------------------------------------------------------
#	Sub-seccion GMT
	gmtset GMT_VERBOSE w

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Abrir archivo de salida (ps)
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > %OUT%

#	Pintar areas secas
	gmt pscoast -R -J -O -K -Df -G200 >> %OUT%

#	Dibujar Antartida_Argentina. 
#	Los meridianos 74° Oeste y 25° Oeste y el paralelo 60° Sur y el Polo Sur.
	echo -74 -60 > temp_Antartida_Argentina
	echo -74 -90 >> temp_Antartida_Argentina
	echo -25 -60 >> temp_Antartida_Argentina
	gmt psxy -R -J -O -K temp_Antartida_Argentina -L -Am -Grosybrown2 -W0.25 >> %OUT%

#	Pintar areas húmedas: Oceanos (-S) y Lagos (-C)
#	gmt pscoast -R -J -O -K -Sdodgerblue2 >> %OUT%
	gmt pscoast -R -J -O -K -Sdodgerblue2 -C200 >> %OUT%

#	Dibujar Paises (N1 paises)
	gmt pscoast -R -J -O -K -N1/0.2,- >> %OUT%

#	Dibujar Linea de Costa
	gmt pscoast -R -J -O -K -Df -W1/ >> %OUT%

#	Resaltar paises DCW (-E), (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur). Pintar de color (+g), Dibujar borde (+p).
	gmt pscoast -R -J -O -K -EAR,FK,GS+grosybrown2+p >> %OUT%

#	Dibujar marco del mapa. Anotaciones (a), marco (f) y lineas de grillados (g)
#	gmt psbasemap -R -J -O -K -Bg >> %OUT%
	gmt psbasemap -R -J -O -K -Bafg >> %OUT%

#	Dibujar paralelos principales y meridiano de Greenwich a partir del archivo paralelos.txt -Am (lineas siguen meridianos)
	gmt psxy -R -J -O -K paralelos.txt -Ap -W0.50,.- >> %OUT% 

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> %OUT%

#	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert %OUT% -Tg -A

	del temp_*

#	Ejercicios Sugeridos:
#	1. Cambiar REGION para que el Mapa se extienda hasta el tropico de Cancer (23) y el ecuador (0)
#	2. Cambiar REGION para que dibujar una "rebanada" del polor sur. Entre Longitudes -90 y 0.
# 	3. Cambiar PROJ y REGION para dibujar el polo norte.

