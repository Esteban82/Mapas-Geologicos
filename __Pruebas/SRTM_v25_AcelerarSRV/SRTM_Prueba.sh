#!/usr/bin/env bash
clear

#	Definir variables del mapa
#	-----------------------------------------------------------------------------------------------------------
#	Titulo del mapa
	title=Probar_SRTM25
	echo $title

#	Region: Argentina
	REGION=d

#	Proyeccion Mercator (M)
	PROJ=W15c

#	Resoluciones grillas: 01d, 30m, 20m, 15m, 10m, 06m, 05m, 04m, 03m, 02m, 01m, 30s, 15s, 03s, 01s.
	RES=01d

#	Fuentes a utilizar
	Origin=/g/gmtserver-admin/staging/SRTM_ORIGINAL/earth/earth_relief/
	Prueba=/g/gmtserver-admin/staging/earth/earth_relief/
	
	# tiled (path a archivos previos a crear el tiled)
	#Origin=/g/gmtserver-admin/staging/SRTM_ORIGINAL/tiled/
	#Prueba=/g/gmtserver-admin/staging/tiled/

	# GRD a comparar. Original (_O) y Prueba (_T)
	GRD_O=${Origin}earth_relief_${RES}_g.grd
	GRD_T=${Prueba}earth_relief_${RES}_g.grd

#	Dibujar mapa
#	-----------------------------------------------------------------------------------------------------------
#	Iniciar sesion y tipo de figura
	gmt begin ${title}_${RES} png
	
#	Setear la region y proyeccion
	gmt basemap -R$REGION -J$PROJ -B+n

#	Crear Imagen a partir de grilla. Usa el CPT por defecto y la ajusta al rango de valores de alturas automaticamente.
#	gmt grdimage $GRD

#	Idem y agrega efecto de sombreado. a= azimut. nt1=metodo de ilumninacion
	gmt grdimage ${GRD_O} -I -Cgeo
	gmt grdimage ${GRD_T} -I -Cgeo -Yh

#	Agregar escala de colores a partir de CPT (-C). Posición (x,y) +wlargo/ancho. Anotaciones (-Ba). Leyenda (+l). 
 	#gmt colorbar -DJRB+o0.3c/0+w90%/0.618c -I -Baf -By+l"km" -W0.001

	gmt grdmath ${GRD_O} ${GRD_T} SUB = diff.nc -V
	#gmt grdinfo diff.nc
	gmt makecpt -Cpolar -T-1/1
	gmt grdimage diff.nc -C -Yh

	gmt colorbar -DJRM+o0.3c/0+w90%/0.618c -Baf -By+l"m"

#	Extraer datos alturas (ponderados por area -Wa) de la grilla y guardarlos como binarios
#	-------------------------------------------------------------
	gmt grd2xyz diff.nc > dif_${RES}.txt -o2
	gmt histogram dif_${RES}.txt -Io -Z1 -T0.1 > dif_${RES}_histogram.txt

#	-----------------------------------------------------------------------------------------------------------
#	Dibujar frame
#	gmt basemap -B

#	Dibujar Linea de Costa (W1)
	gmt coast -Da -W1/faint

#	-----------------------------------------------------------------------------------------------------------
#	Cerrar el archivo
gmt end