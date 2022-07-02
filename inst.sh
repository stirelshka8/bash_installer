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
		echo "[+] СОЗДАНА ВРЕМЕННАЯ ДИРЕКТОРИЯ ПРОГРАММЫ"
		#
		# здесь разместить код для скачивания с GitHub в папку /tmp/solstmp
		#
		cd /usr/bin
		mkdir solsdev
		echo "[+] СОЗДАНА РАБОЧАЯ ДИРЕКТОРИЯ ПРОГРАММЫ"
		chmod -R 777 ~/solsdev
		cp -f /tmp/solstmp/Netology.py /usr/bin/solsdev
		cd ~/solsdev
		echo "[+] КОПИРОВАНИЕ ФАЙЛОВ ЗАВЕРШЕНО"
        #pip3 install colorama
        #pip3 install art
		#echo "[+] БИБЛИОТЕКИ УСТАНОВЛЕННЫ"
		#echo "НАЧАЛО УДАЛЕНИЯ ВРЕМЕННЫХ ФАЙЛОВ"
		#rm -Rv /tmp/solstmp/
		#echo "[+] УДАЛЕНИЕ ВРЕМЕННЫХ ФАЙЛОВ ЗАВЕРШЕНО
		
		# --------------------------------------------
		rm -Rv /tmp/solstmp/
		rm -Rv /usr/bin/solsdev/
		# --------------------------------------------

	else
		echo " >>>>>>> Программа уже установлена!!! <<<<<<<"
		echo -n "         Удалить (да/нет): "
		read DELPAR

		if [[ $DELPAR = да ]]
		then
			rm -Rv /usr/bin/solsdev/
			echo "[+] ПРОГРАММА ПОЛНОСТЬЮ УДАЛЕНА"
		else
			echo "[+] ВЫХОД"
			exit
		fi
	fi
fi