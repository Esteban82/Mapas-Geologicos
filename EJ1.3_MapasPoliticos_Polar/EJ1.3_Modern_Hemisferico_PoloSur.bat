ECHO OFF
cls


REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Titulo del mapa
	SET	title=EJ1.3_Modern_Hemisferico_PoloSur
	echo %title%

rem	Proyecciones acimutales requieren 3 parametros + 1 opcional (lon0/lat0[/horizon]/width
rem	L(a)mbert Equal Area; (S)tereographic; Orto(g)rafica; (E)quidistante
rem	SET	PROJ=G-65/-30/15c
	SET	PROJ=S-65/-90/15c

REM	Region geografica del mapa (W/E/S/N) d=-180/180/-90/90 g=0/360/-90/90
rem	SET	REGION=d
	SET	REGION=-180/180/-90/-60

REM 	Nombre archivo de salida
	SET	OUT=%title%.ps

REM	Parametros por Defecto
REM	-----------------------------------------------------------------------------------------------------------

REM	Sub-seccion GMT
	gmtset GMT_VERBOSE c

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Abrir archivo de salida (ps)
	gmt begin %title% png

REM	Setear la region y proyeccion
	gmt basemap -R%REGION% -J%PROJ% -B+n

REM	Pintar areas secas
	gmt coast -Df -G200

REM	Dibujar Antartida_Argentina. 
REM	Los meridianos 74° Oeste y 25° Oeste y el paralelo 60° Sur y el Polo Sur.
REM	Crear archivo con coordendas.
	echo -74 -60 >  "temp_Antartida_Argentina"
	echo -74 -90 >> "temp_Antartida_Argentina"
	echo -25 -60 >> "temp_Antartida_Argentina"

REM	Dibujar archivo previo. Borde (-Wpen), Relleno (-Gfill), Lineas siguen meridianos (-Am), Cerrar polígonos (-L)
	gmt plot "temp_Antartida_Argentina" -L -Am -Grosybrown2 -W0.25

REM	Pintar areas húmedas: Oceanos (-S) y Lagos (-C)
rem	gmt coast -Sdodgerblue2
	gmt coast -Sdodgerblue2 -C200

REM	Dibujar Paises (N1 paises)
	gmt coast -N1/0.2,-

REM	Dibujar Linea de Costa
	gmt coast -Df -W1/

REM	Resaltar paises DCW (-E), (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur). Pintar de color (+g), Dibujar borde (+p).
	gmt coast -EAR,FK,GS+grosybrown2+p

REM	Dibujar marco del mapa. Anotaciones (a), marco (f) y lineas de grillados (g)
rem	gmt basemap -Bg
	gmt basemap -Bafg

REM	Dibujar paralelos principales y meridiano de Greenwich a partir del archivo paralelos.txt -Am (lineas siguen meridianos)
	gmt plot "paralelos.txt" -Ap -W0.50,.-

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida (ps)
	gmt end show

	del temp_* %OUT% gmt.*

REM	Ejercicios Sugeridos:
REM	1. Cambiar REGION para que el Mapa se extienda hasta el tropico de Cancer (23) y el ecuador (0)
REM	2. Cambiar REGION para que dibujar una "rebanada" del polor sur. Entre Longitudes -90 y 0.
REM 	3. Cambiar PROJ y REGION para dibujar el polo norte.
