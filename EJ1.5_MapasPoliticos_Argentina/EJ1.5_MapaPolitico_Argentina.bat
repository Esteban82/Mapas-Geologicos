ECHO off
cls

REM	Definir variables del mapa
REM	-----------------------------------------------------------------------------------------------------------
REM	Titulo del mapa
	SET	title=EJ1.5_MapaPolitico_Argentina_New
	echo %title%

REM	Region: Buenos Aires
	SET	REGION=-64/-42/-56/-33r

REM	Region: Argentina
rem	SET	REGION=-78/-50/-56/-21
	SET	REGION=-81/-55/-53/-21r

REM	Proyecciones Cilindricas: 
REM	(C)assini, C(y)lindrical equal area: Lon0/lat0/Width
REM	Miller cylindrical (J): Lon0/Width
REM	(M)ercartor, E(q)udistant cilindrical, (T)ransverse Mercator: (Lon0(/Lat0/))Width
REM	(U)TM: Zone/Width
rem	SET	PROJ=C-65/-35/13c
rem	SET	PROJ=J-65/13c
	SET	PROJ=T-60/-30/13c
rem	SET	PROJ=M1-5c
rem	SET	PROJ=U-20/13c

REM 	Nombre archivo de salida
	SET	OUT=%title%.ps

	gmtset GMT_VERBOSE w

REM	Dibujar mapa
REM	-----------------------------------------------------------------------------------------------------------
rem	Abrir archivo de salida (ps)
	gmt psxy -R%REGION% -J%PROJ% -T -K -P > %OUT%

rem	Pintar areas húmedas: Oceanos (-S) y Lagos (-Cl/) y Rios-Lagos (-Cr/)
	Set color=dodgerblue2
	gmt pscoast -R -J -O -K -Df -S%color% -Cl/green -Cr/red >> %OUT%

REM	Resaltar paises DCW (AR: Argentina soberana, FK: Malvinas, GS: Georgias del Sur y Sandwich del Sur)
	gmt pscoast -R -J -O -K -EAR,FK,GS+grosybrown2+p >> %OUT%

REM	Datos Instituto Geografico Nacional (IGN)
REM	-----------------------------------------------------------------------------------------------------------
REM	Descripcion psxy: Lineas (-Wpen), Puntos (-Ssímbolo/size), Relleno simbolos o polígonos (-Gfill).
REM	-G: pinta el area definida por los puntos.
REM	-G y -W: Pinta el área y dibuja las lineas del borde
REM	-W: Dibuja las lineas del borde 
REM	-S: dibuja los simbolos sin relleno
REM	-S -G: dibuja simbolos con relleno
REM	-S -W -G: dibuja simbolos con relleno y borde

REM	Cursos y Cuerpos de Agua
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\004_Cuerpos_De_Agua.gmt" -G%color% 
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\001_Cursos_De_Agua.gmt"  -Wfaint,blue

REM	Departamentos
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\Departamentos.gmt" -Wthinnest,-

REM	Limites administrativos
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\limites_politico_administrativos.gmt" -Wthinner

REM 	Red vial y ferroviaria
rem	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\002_Red_Vial.gmt"        -Wthin,blue
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\003_Red_Ferroviaria.gmt" -Wthin,red

REM	Pueblos y Ejidos Urbanos. -SsimboloTamaño. Simbolos: A (star), C (Círculo), D (Diamante), G (octagono), H (hexagono), I (triangulo invertido), N (pentagono), S (cuadrado), T (triangulo). 
REM	Tamaño: diámetro del círculo (Mayuscula: misma área que el circulo; Minúscula (diámetro del círculo que abarca a las símbolos)
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt" -Sc0.05 -Ggreen -Wred
	gmt psxy -R -J -O -K >> %OUT% "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\010_Ejidos_Urbanos.gmt"   -Wfaint -Ggreen

REM	Pueblos. Ejercicio. Combinación de -S -W -G
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt" -Sc0.05 -Wred -Ggreen >> %OUT%
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt" -Sc0.05 -Wred 	     >> %OUT%
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt" -Sc0.05       -Ggreen >> %OUT%
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt"         -Wred -Ggreen >> %OUT%
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt"         -Wred         >> %OUT%
rem	gmt psxy -R -J -O -K "E:\Facultad\Datos_Geofisicos\IGN\1_GMT\005_Centros_Poblados.gmt"               -Ggreen >> %OUT%

REM	Datos de GSHHG
REM	-----------------------------------------------------------------------------------------------------------
REM	Dibujar Marco. -B0 solo borde. -Baf con anotaciones y marcas automaticas.
rem	gmt psbasemap -R -J -O -K -Ba4f2/a2f1 >> %OUT%
	gmt psbasemap -R -J -O -K -Baf >> %OUT%
rem	gmt psbasemap -R -J -O -K -B0 >> %OUT%

REM	Dibujar Bordes Administrativos. N1: paises. N2: Provincias, Estados, etc. N3: limites marítimos (Nborder[/pen])
	gmt pscoast -R -J -O -K -Df -N1/0.75 >> %OUT%

REM	Dibujar Linea de Costa (level/, where level is 1-4 and represent coastline, lakeshore, island-in-lake shore, and lake-in-island-in-lake shore). -Amin_area(/min_level/max/level): Filtro para dibujar lineas de costa.
rem	gmt pscoast -R -J -O -K -Df -W1/faint >> %OUT%
	gmt pscoast -R -J -O -K -Df -Wfaint   >> %OUT% -A0/0/4 

REM	-----------------------------------------------------------------------------------------------------------
REM	Cerrar el archivo de salida (ps)
	gmt psxy -R -J -T -O >> %OUT%

REM	Convertir ps en otros formatos: EPS (e), PDF (f), JPEG (j), PNG (g), TIFF (t)
	gmt psconvert %OUT% -Tg -A

	pause
	del temp_* %OUT% *.gmt

REM	-----------------------------------------------------------------------------------------------------------
REM	Ejercicios Sugeridos:
REM	1. Rehacer el mapa combinando las distintas proyecciones cilíndricas y los 2 métodos para definir la región. Ver en que combinaciones el mapa es rectangular y en cuales tiene un borde elegante. 
REM	2. Descargar datos del IGN (en formato SHP): Cuerpos de Agua (polígono), Centros poblados (punto) y red vial o ferrea (línea). 
REM	3. Convertirlos a formato GMT con el programa OGR2GUI.
REM	4. Guardar en una carpeta y reemplazar en el script la ruta absoluta de los archivos.
REM	5. Ejercicio de combinación de argumentos -S -G -W para dibujar símbolos, líneas y áreas.
REM	6. Dibujar los pueblos con distintos símbolos (estrella, cuadrado, círculo). Utilizar mayúsculas y minúsculas.
