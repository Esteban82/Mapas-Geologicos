	ECHO OFF
	cls

REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------

REM	Titulo del mapa
	SET	title=EJ1.1_Mapamundi
	echo %title%

REM	Proyecciones miscelaneas. Requiere 1 parámetro opcional: (Lon0/). Meridiano central.
REM	Mollweide (W), Hammer (H), Winkle Triple (R), Robinson (N), Eckert IV (Kf) y VI (Ks), Sinusoidal (I), Van der Grinten (V)
REM	Ancho (o alto "h") en cm (c), pulgadas (i) o puntos (p). Ej.: 15 cm de ancho (/15c). 10 cm de alto (/10ch).
	SET	PROJ=W15c
	SET	PROJ=W-65/15c
REM	SET	PROJ=W-65/10ch
	
REM	Region geografica del mapa (W/E/S/N) d=-180/180/-90/90 g=0/360/-90/90
	SET	REGION=d

REM 	Nombre archivo de salida a partir del titulo (no modificar)
	SET	OUT=%title%.ps

REM	Parametros por Defecto
REM	-----------------------------------------------------------------------------------------------------------

REM	Sub-seccion GMT
	gmtset GMT_VERBOSE q

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Abrir archivo de salida (ps). Crea Header.
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > %OUT%

REM	Pintar areas secas (-Gcolor)
	gmt pscoast -R -J -O -K >> %OUT% -G200 

REM	Pintar areas húmedas (-SColor). Oceanos, Mares, Lagos y Rios.
	gmt pscoast -R -J -O -K >> %OUT% -Sdodgerblue2

REM	Dibujar Linea de Costa con un ancho (-Wpen) de 0.25 
	gmt pscoast -R -J -O -K >> %OUT% -W -A0/0/4

REM	Dibujar limite de Paises (N1:pen División administrativa 1, países) 
	gmt pscoast -R -J -O -K >> %OUT% -N1/0.2,-

REM	Dibujar marco del mapa (-B). Lineas de grillas (g). 
	gmt psbasemap -R -J -O -K >> %OUT% -B0
	gmt psbasemap -R -J -O -K >> %OUT% -Bg

REM	Dibujar paralelos principales y meridiano de Greenwich a partir del archivo paralelos.txt -Ap (lineas siguen paralelos)
	gmt psxy -R -J -O -K paralelos.txt -Ap -W0.50,.- >> %OUT% 

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida (ps), Crea Trailer.
	gmt psxy -R -J -T -O >> %OUT%

REM	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t). -A ajusta imagen a la minima requerida.
	gmt psconvert %OUT% -Tg -A

	del %OUT% gmt.*
