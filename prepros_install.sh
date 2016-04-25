#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#Requiere de permisos de ejecución:$chmod -x prepros_install.sh
#Ejecutar como Root: $bash prepros_install.sh

#Validando Acceso Root
if [[ $EUID -ne 0 ]]; then
echo "Tienes que ejecutar este script como Root" 1>&2
exit 1
fi

#Variables
rutaPrepros32=/opt/Prepros-linux-32/
rutaPrepros64=/opt/Prepros-linux-64/

version=5.10.2
prepros64=http://prepros.io.s3.amazonaws.com/installers/Prepros-Linux-$version-64.zip
prepros32=http://prepros.io.s3.amazonaws.com/installers/Prepros-Linux-$version-32.zip

limite=--limit-rate=800k

while :
do
clear
echo "
#----------------------------------------#
         Prepros $version Installer      
#----------------------------------------#
#           github.com/heckctor          #
#----------------------------------------#
"
echo "Selecciona la arquitectura de tu procesador"
echo "1. 32 Bits"
echo "2. 64 Bits"
echo "3. Cancelar Instalación"

echo -n  "Seleccione una opción [1 - 3]. "
 
read opcion


case $opcion in

1) clear;
echo "Seleccionaste 32 bits"
prepros=$rutaPrepros32/Prepros
#Validando si ya está Prepros instalado, y si esta no lo instala
if [ ! -e $prepros ]; then
echo "Se procederá con la descarga de Prepros v"$version "32 bits"
sleep 3s

wget -r -c $limite $prepros32 -P /tmp/ 

clear
echo "La descarga ha finalizado, se procederá con la instalación"
sleep 3s
archivoDescargado=/tmp/prepros.io.s3.amazonaws.com/installers/Prepros-Linux-$version-32.zip
unzip $archivoDescargado -d /opt/
clear
echo "Creando acceso directo..."
sleep 3s
echo "
#!/usr/bin/env xdg-open
[Desktop Entry]
Categories=Development
Comment=Prepros is great
Exec=/opt/Prepros-linux-32/Prepros
Hidden=false
Icon=/opt/Prepros-linux-32/resources/app/icon.png
Name=Prepros
Terminal=false
Type=Application
Version=5.10.2
MimeType=text/html;
Keywords=Text;Editor;Write;Web;Development;
" > /usr/share/applications/Prepros.desktop
clear
echo "Creando Desinstalador..."
mkdir $HOME/.prepros-u/
echo "
#!/bin/bash
# -*- ENCODING: UTF-8 -*-
rm -r /opt/Prepros-linux-32/ /usr/share/applications/Prepros.desktop $HOME/.prepros-u/
echo "Se desinstaló Prepros"
" > $HOME/.prepros-u/desinstalar.sh
sleep 1s
chmod -x $HOME/.prepros-u/desinstalar.sh
echo "Para desinstalar Prepros $version ejecuta en la terminal:"
echo "sudo bash $HOME/.prepros-u/desinstalar.sh"
sleep 1s

echo "Se borraron archivos temporales"
rm -r $archivoDescargado

echo "Prepros $version 32 bits se instalo correctamente"

else
echo "Ya tienes instalado Prepros, y no se instalará..."
exit
fi


exit 1;;

2) clear;
echo "Seleccionaste 64 bits"
prepros=$rutaPrepros64/Prepros
#Validando si ya está Prepros instalado, y si está no lo instala
if [ ! -e $prepros ]; then
echo "Se procederá con la descarga de Prepros v"$version "64 bits"
sleep 3s

wget -r -c $limite $prepros64 -P /tmp/ 

clear
echo "La descarga ha finalizado, se procederá con la instalación"
sleep 3s
archivoDescargado=/tmp/prepros.io.s3.amazonaws.com/installers/Prepros-Linux-$version-64.zip
unzip $archivoDescargado -d /opt/
clear
echo "Creando acceso directo..."
sleep 3s
echo "
#!/usr/bin/env xdg-open
[Desktop Entry]
Categories=Development
Comment=Prepros is great
Exec=/opt/Prepros-linux-64/Prepros
Hidden=false
Icon=/opt/Prepros-linux-64/resources/app/icon.png
Name=Prepros
Terminal=false
Type=Application
Version=5.10.2
MimeType=text/html;
Keywords=Text;Editor;Write;Web;Development;
" > /usr/share/applications/Prepros.desktop
clear
echo "Creando Desinstalador..."
mkdir $HOME/.prepros-u/
echo "
#!/bin/bash
# -*- ENCODING: UTF-8 -*-
rm -r /opt/Prepros-linux-64/ /usr/share/applications/Prepros.desktop $HOME/.prepros-u/
echo "Se desinstaló Prepros"
" > $HOME/.prepros-u/desinstalar.sh
sleep 1s
chmod -x $HOME/.prepros-u/desinstalar.sh
echo "Para desinstalar Prepros $version ejecuta en la terminal:"
echo "sudo bash $HOME/.prepros-u/desinstalar.sh"
sleep 1s

echo "Se borraron archivos temporales"
rm -r $archivoDescargado

echo "Prepros $version 64 bits se instaló correctamente"

else
echo "Ya tienes instalado Prepros, y no se instalará... Adios..."
exit
fi


exit 1;;

3)clear 
echo  "Bye!"

exit 1;;

*) echo " "$opcion" es una opción inválida, teclea el número 1, 2 ó 3";

echo "Presiona cualquier tecla y pulsa ENTER continuar...";

read foo
clear;;

esac

done
