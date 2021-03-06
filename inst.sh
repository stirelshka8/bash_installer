#!/bin/bash

#set -o errexit # Данная команда завершает работу скрипта при ошибке

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

# При "подгонке" скрипта под себя достаточно изменить переменные указанные ниже

SETTMP=solstmp # Переменная для создания временной директории
SETDIR=solsdev # Переменная для создания рабочей директории
PATHINST=/usr/bin/$SETDIR # Переменная рабочей директории
PATHTEMP=/tmp/$SETTMP # Переменная директории временных файлов
PATHICO=/usr/share/icons # Переменная дериктории где лежит иконка программы (не забыть прописать путь в ярлыке)
NAMEAPP=app # Переменная названия ярлыка запуска
NAMEICO=solsicons # Переменная названия иконки программы
NAMESCR=startup # Переменная названия скрипта запуска программы
NAMEZIP=main # Переменная названия скачиваемого архива
DOWNLINK=https://repo.solsdev.site/mian/$NAMEZIP.zip # Переменная ссылки на скачивание программы

# ---------
# echo -n "Введите полный путь до рабочего стола - "
# read DESKPATH
# ---------
# TODO: Исправить ошибку пути
PATHDESKTOP=home/stirelshka/Рабочий\-nстол/

# ******************************************************************************

if [ "$(whoami)" != 'root' ];
then
	echo "Установка невозможна!!! Необходимы права суперпользователя."
    echo "Запустите скрипт с правами суперпользователя >>> sudo [ПУТЬ К СКРИПТУ]/inst.sh <<<"
	exit
else
	if ! [ -d $PATHINST ]
	then
		cd /tmp

		if ! mkdir $SETTMP; 
		then
    	echo "ОШИБКА СОЗДАНИЯ ВРЕМЕННОЙ ПАПКИ"
		echo "ЕСЛИ ВРЕМЕННАЯ ПАПКА БЫЛА СОЗДАНА РАНЕЕ, ТО ОНА УДАЛИТСЯ!"
		rm -Rv $PATHTEMP
		exit
		else
		echo -e "\033[41m\033[30m [+] СОЗДАНА ВРЕМЕННАЯ ДИРЕКТОРИЯ ПРОГРАММЫ \033[0m"
		fi

		chmod -R 777 $PATHTEMP
		cd $PATHTEMP

		echo -e "\033[41m\033[30m [*] НАЧАЛО ЗАГРУЗКИ ФАЙЛА ПРОГРАММЫ \033[0m"
		# TODO: Проблемма скачивания в repo.solsdev.site, почему то не идет загрузка.
		if ! wget -q $DOWNLINK;
		then
    	echo "ОШИБКА ЗАГРУЗКИ ФАЙЛА"
		exit
		else
		echo -e "\033[41m\033[30m [+] ЗАГРУЗКА ФАЙЛА ЗАВЕРШЕНА УСПЕШНО \033[0m"
		fi
		echo -e "\033[41m\033[30m [*] НАЧАЛО РАСПАКОВКИ АРХИВА \033[0m"

		#unzip -j $NAMEZIP.zip \*.py -d $PATHTEMP # распаковываем только .py файлы и не обращаем внимание на вложенные папки
		if ! unzip -j $NAMEZIP.zip -d $PATHTEMP; # распаковываем все не обращая внимания на вложенные папки (-j) 
		then
    	echo "ОШИБКА РАСПАКОВКИ ФАЙЛА"
		exit
		else
		echo -e "\033[41m\033[30m [+] РАСПАКОВКА ФАЙЛА ЗАВЕРШЕНА УСПЕШНО \033[0m"
		fi		

		cd /usr/bin

		if ! mkdir $SETDIR; 
		then
    	echo "ОШИБКА СОЗДАНИЯ РАБОЧЕЙ ДИРЕКТОРИИ"
		exit
		else
		echo -e "\033[41m\033[30m [+] РАБОЧАЯ ДИРЕКТОРИЯ СОЗДАНА  УСПЕШНО \033[0m"
		fi	

		chmod -R 777 $PATHINST
		echo -e "\033[41m\033[30m [*] НАЧАЛО КОПИРОВАНИЯ ФАЙЛОВ В РАБОЧУЮ ДИРЕКТОРИЮ \033[0m"
		cp -f $PATHTEMP/*.py $PATHINST # копируем все файла с расширением .py
		cp -f $PATHTEMP/$NAMEAPP.desktop $PATHINST
		cp -f $PATHTEMP/$NAMEICO.ico $PATHICO/$NAMEICO.ico
		cp -f $PATHTEMP/$NAMESCR.sh $PATHINST
		echo -e "\033[41m\033[30m [+] КОПИРОВАНИЕ ФАЙЛОВ ЗАВЕРШЕНО \033[0m"
		cd $PATHINST
		# --------------------------------------------
		# Здесь прописываем все нужные библиотеки
        #pip3 install colorama
        #pip3 install art
		#echo -e "\033[41m\033[30m [+] БИБЛИОТЕКИ УСТАНОВЛЕННЫ \033[0m"
		# --------------------------------------------
		echo -e "\033[41m\033[30m [*] НАЧАЛО УДАЛЕНИЯ ВРЕМЕННЫХ ФАЙЛОВ \033[0m"
		if ! rm -Rv $PATHTEMP; 
		then
    	echo "ОШИБКА УДАЛЕНИЯ ВРЕМЕННЫХ ФАЙЛОВ"
		exit
		else
		echo -e "\033[41m\033[30m [+] УДАЛЕНИЕ ВРЕМЕННЫХ ФАЙЛОВ ЗАВЕРШЕНО \033[0m"
		fi
		# --------------------------------------------
		echo -e "\033[42m\033[30m [+] УСТАНОВКА ПРОГРАММЫ ЗАВЕРШЕНА \033[0m"
		echo
		echo -e "\033[42m\033[30m Желаете создать ярлык запуска на рабочем столе? \033[0m"
		echo -n "         Создать (да/нет): "
		read STARTPAR

		if [[ $STARTPAR = да ]]
		then
			if ! cp -l $PATHINST/$NAMEAPP.desktop /$PATHDESKTOP; 
			then
    		echo "ОШИБКА СОЗДАНИЯ ЯРЛЫКА"
			exit
			else
			echo -e "\033[41m\033[30m [+] ЯРЛЫК СОЗДАН НА РАБОЧЕМ СТОЛЕ \033[0m"
			fi
		else
			echo -e "\033[41m\033[30m [!] ЯРЛЫК НЕ СОЗДАН \033[0m"
		fi

	else
		echo -e "\033[41m\033[30m >>>>>>> Программа уже установлена!!! <<<<<<< \033[0m"
		echo -n "         Удалить (да/нет): "
		read DELPAR
		if [[ $DELPAR = да ]]
		then
			if ! rm -Rv $PATHINST; 
			then
    		echo "ОШИБКА УДАЛЕНИЯ ПРОГРАММЫ"
			exit
			fi
			if ! rm -v $PATHICO/$NAMEICO.ico; 
			then
    		echo "ОШИБКА УДАЛЕНИЯ ИКОНКИ ПРОГРАММЫ"
			exit
			fi
			echo -e "\033[41m\033[30m [+] ПРОГРАММА ПОЛНОСТЬЮ УДАЛЕНА \033[0m"
		else
			echo -e "\033[41m\033[30m [!] РАБОТА ПРОГРАММЫ ЗАВЕРШЕНА \033[0m"
			exit
		fi
	fi
fi