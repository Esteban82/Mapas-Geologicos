ECHO OFF
cls


REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------

REM	Titulo del mapa     
	SET	title=EJ1.2_Hemisferico
	echo %title%

REM	Proyecciones acimutales requieren 3 parametros + 1 opcional (lon0/lat0[/horizon]/width    V 
	SET	PROJ=A-65/-30/90/15c
	SET	PROJ=G-65/-30/90/15c
     
REM	Region geografica del mapa (W/E/S/N) d=-180/180/-90/90 g=0/360/-90/90
	SET	REGION=d

REM 	Nombre archivo de salida
	SET	OUT=%title%.ps

REM	Parametros por Defecto
REM	-----------------------------------------------------------------------------------------------------------

REM	Sub-seccion GMT
	gmtset GMT_VERBOSE c

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Iniciar sesion y tipo de figura
	gmt begin %title% png

REM	Setear la region y proyeccion
	gmt basemap -R%REGION% -J%PROJ% -B+n

REM	Pintar areas secas (-G). Resolucion datos full (-Df)
	gmt coast -Df -G200

REM	Dibujar Antartida_Argentina. 
REM	Los meridianos 74° Oeste y 25° Oeste y el paralelo 60° Sur y el Polo Sur.
REM	Crear archivo con coordendas.
	echo -74 -60 >  "tmp_Antartida_Argentina"
	echo -74 -90 >> "tmp_Antartida_Argentina"
	echo -25 -60 >> "tmp_Antartida_Argentina"

REM	Dibujar archivo previo. Borde (-Wpen), Relleno (-Gfill), Lineas siguen meridianos (-Am), Cerrar polígonos (-L)
	gmt plot "tmp_Antartida_Argentina" -L -Am -Grosybrown2 -W0.25

REM	Pintar areas húmedas: Oceanos (-S) y Lagos y Rios (-C).
REM	gmt coast -Sdodgerblue2 
	gmt coast -Sdodgerblue2 -C200
rem	gmt coast -Sdodgerblue2 -C- 
rem	gmt coast -Swhite -C200 

REM	Dibujar Paises (1 paises, 2 estados/provincias en America, 3 limite maritimo)
	gmt coast -N1/0.2,-

REM	Dibujar Linea de Costa
	gmt coast -Df -W1/

REM	Resaltar paises DCW (-E). Codigos ISO 3166-1 alph-2. (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur). Pintar de color (+g), Dibujar borde (+p). 
	gmt coast -EAR,FK,GS+grosybrown2+p
	
REM	Resaltar provincias DCW (-E). Codigos ISO 3166-2:AR (X: Cordoba, L: La Pampa, J: San Juan).
rem	gmt pscoast -R -J -O -K -EAR.X,AR.L,AR.J+gorange+p >> %OUT%

REM	Dibujar marco del mapa 
	gmt psbasemap -Bg

REM	Dibujar paralelos principales y meridiano de Greenwich a partir del archivo paralelos.txt -Am (lineas siguen meridianos)
	gmt plot "paralelos.txt" -Ap -W0.50,.- 

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida
	gmt end show

	del tmp_* gmt.*