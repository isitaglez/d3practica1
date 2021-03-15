#! /bin/bash
# Projection compatible with Google Maps
PROJECTION="+proj=longlat +ellps=WGS84 +no_defs +towgs84=0,0,0"
# wget command
WGET="wget -w 5 --random-wait --tries=2 -nc"

# The mapa digital is available as 4 files
declare -a extensions=(".exe" "-1.bin" "-2.bin" "-3.bin")

$WGET "http://internet.contenidos.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/nueva_estruc/promo/Instalador_proy_bas_inf_2017.zip" -O md.zip
unzip md.zip Instalador_proy_bas_inf_2017.exe 


echo "Extracting shapefiles..."
innoextract --lowercase --silent Instalador_proy_bas_inf_2017.exe
echo "Reprojecting shapefiles..."
find .  -name '*.shp' -execdir ogr2ogr {} {} -overwrite -t_srs "$PROJECTION" \;
mv "app/proyecto basico de informacion 2017" "mapa_digital_2017"
rm -rf app
rm -rf tmp
rm -rf Instalador_proy_bas_inf_2017.exe
