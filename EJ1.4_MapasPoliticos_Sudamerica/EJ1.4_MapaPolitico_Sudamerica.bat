ECHO OFF
cls

REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------

REM	Titulo del mapa
	SET	title=EJ1.4_MapaPolitico_Sudamerica
	echo %title%

rem	Region: Sudamérica
	SET	REGION=-85/-33/-58/15

rem	Proyeccion Conica. (lon0/lat0/lat1/lat2/width) Proyeccion Albers (B); Lambert (L): Equidistant (D).
rem	SET	PROJ=D-60/-30/-40/0/15c
	SET	PROJ=B-60/-30/-40/0/15c

REM 	Nombre archivo de salida
	SET	OUT=%title%.ps

REM	Parametros por Defecto
REM	-----------------------------------------------------------------------------------------------------------

REM	Sub-seccion GMT
	gmtset GMT_VERBOSE c

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Abrir archivo de salida (ps)
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > %OUT%

REM	Resaltar paises DCW (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur y Sandwich del Sur, CO: Colombia)
	gmt pscoast -R -J -O -K -EAR,FK,GS+grosybrown2+p >> %OUT%

REM	Pintar areas húmedas: Oceanos (-S) y Lagos (-Cl/)f
	Set color=117/197/240
	gmt pscoast -R -J -O -K -Df -Sdodgerblue2 -Cl/%color% >> %OUT%

REM	Dibujar Bordes Administrativos. N1: paises. N2: Provincias, Estados, etc. N3: limites marítimos (Nborder[/pen])
	gmt pscoast -R -J -O -K -Df -N1/0.75 >> %OUT%
	gmt pscoast -R -J -O -K -Df -N2/0.25,-. >> %OUT%

REM	Dibujar Linea de Costa (level/, where level is 1-4 and represent coastline, lakeshore, island-in-lake shore, and lake-in-island-in-lake shore)
	gmt pscoast -R -J -O -K -Df -W1/0.25 >> %OUT%

REM	Dibujar rios -Iriver[/pen] 
REM	0 = Double-lined rivers (river-lakes)
REM	1 = Permanent major rivers
REM	2 = Additional major rivers
REM	3 = Additional rivers
REM	4 = Minor rivers
	gmt pscoast -R -J -K -O -Df -I0/thin,%color% >> %OUT%	
	gmt pscoast -R -J -K -O -Df -I1/thinner,%color% >> %OUT%
	gmt pscoast -R -J -K -O -Df -I2/thinner,%color%,- >> %OUT%
	gmt pscoast -R -J -K -O -Df -I3/thinnest,%color%,-... >> %OUT%
	gmt pscoast -R -J -K -O -Df -I4/thinnest,%color%,4_1:0p >> %OUT%

REM	Dibujar frame
	gmt psbasemap -R -J -O -K -Baf >> %OUT%

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> %OUT%

REM	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert %OUT% -Tg -A

	del temp_* gmt.*

REM	Ejercicios Sugeridos:
REM	1. Modificar REGION para que abarque a Europa.
REM	2. Modificar el color de los rios (variable %color%).
REM	3. Modificar las lineas de os rios (ancho, estilo de linea).
