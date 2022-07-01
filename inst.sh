#!/bin/bash

clear
echo " ___   __    _  _______  _______  _______  ___      ___     
|   | |  |  | ||       ||       ||   _   ||   |    |   |    
|   | |   |_| ||  _____||_     _||  |_|  ||   |    |   |    
|   | |       || |_____   |   |  |       ||   |    |   |    
|   | |  _    ||_____  |  |   |  |       ||   |___ |   |___ 
|   | | | |   | _____| |  |   |  |   _   ||       ||       |
|___| |_|  |__||_______|  |___|  |__| |__||_______||_______|"
echo
echo "************************************************************"


if [ "$(whoami)" != 'root' ];
then
	echo "Установка невозможна!!! Необходимы права суперпользователя."
    echo "Запустите скрипт с правами суперпользователя >>> sudo /tmp/solstmp/inst.sh <<<"
	exit
else
	if ! [ -d /usr/bin/solsdev/ ]
	then
		cd /tmp
		mkdir solstmp
		chmod -R 777 /tmp/solstmp
		echo "[+] СОЗДАНА ВРЕМЕННАЯ ДЕРИКТОРИЯ ПРОГРАММЫ"
		cd /usr/bin
		mkdir solsdev
		echo "[+] СОЗДАНА РАБОЧАЯ ДЕРИКТОРИЯ ПРОГРАММЫ"
		chmod -R 777 ~/solsdev
		cp -f /tmp/solstmp/Netology.py /usr/bin/solsdev
		cd ~/solsdev
		echo "[+] КОПИРОВАНИЕ ФАЙЛОВ ЗАВЕРШЕНО"
        #pip3 install colorama
        #pip3 install art
		#echo "[+] БИБЛИОТЕКИ УСТАНОВЛЕННЫ"
		#echo "НАЧАЛО УДАЛЕНИЯ ВРЕМЕННЫХ ФАЙЛОВ"
		#rm -Rv /tmp/solstmp/
		#echo "[+] УДАЛЕНИЕ ВРЕМЕННЫХ ФАЙЛОВ ЗАВЕРШЕНО"
	else
		echo "                Программа уже установлена!!!"
		exit
	fi
fi