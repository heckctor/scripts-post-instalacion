#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#----------------------------------------#
#         XAMPP INSTALLER v1.0.0         #
#----------------------------------------#
#     By: https://github.com/heckctor    #
#----------------------------------------#
#    ejecutar $bash xampp-files.sh

rutaXampp=/opt/lampp/htdocs
lampp64=https://googledrive.com/host/0B9Y_ljNxd8ubVkRMTWtocTd4aHM/lampp.5.6.19.tar.gz
limite=--limit-rate=800k

#Validando Acceso Root
if [[ $EUID -ne 0 ]]; then
echo "Tienes que ejecutar este script como Root" 1>&2
exit 1
fi
#Validando si ya esta lampp instalado, y si esta no lo instala
lampp=/opt/lampp/lampp
if [ ! -e $lampp ]; then
#echo "No  tienes instalado lampp"
# 1.- Se define la ruta de Instalación
echo "Descargando Xampp V5.6.19"
sleep 2s

# 2.- Se posiciona en la carpeta personal y comienza la descarga Xammp
cd $HOME
wget -r -c $limite $lampp64 -P /tmp/ 
temporales=/tmp/googledrive.com/
archivoDescargado=/tmp/googledrive.com/host/0B9Y_ljNxd8ubVkRMTWtocTd4aHM/lampp.5.6.19.tar.gz
sleep 2s
echo "Finalizo la Descarga"
sleep 1
clear
echo "Instalando Lampp 5.6.19"
tar -xzvf $archivoDescargado -C /opt/
sleep 3s
clear
echo "Borrando Temporales"
rm -r $temporales

sleep 2s
echo "Temporales eliminados"
sleep 3s
ln -s /opt/lampp/lampp /bin/
clear
sleep 1s

# 3.- Se cambian los permisos al directorio htdocs y dentro de el se crea la carpeta www, posteriormente de dicha carpeta de crea un enlace simbolico en la carpeta personal y se finaliza el proceso
echo "Creando enlace simbolico de /opt/lampp/htdocs/www en tu Home"
sleep 3s
chmod 777 $rutaXampp
mkdir $rutaXampp/www
sleep 1s
chmod 777 $rutaXampp/www
sleep 1s
ln -s $rutaXampp/www $HOME/www
echo "¡Proceso Finalizado!"
echo "Tip: Para ejecutarlo desde terminal y como Root escribe:"
echo "lampp start"
else
echo "Ya tienes instalado lampp, y no se instalo... Bye..."
exit
fi

