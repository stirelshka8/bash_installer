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
PATHDESKTOP=/home/stirelshka/Рабочий\ стол/ # Переменная пути где будет создан ярлык

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
		mkdir $SETTMP
		chmod -R 777 $PATHTEMP
		echo -e "\033[41m\033[30m [+] СОЗДАНА ВРЕМЕННАЯ ДИРЕКТОРИЯ ПРОГРАММЫ \033[0m"
		cd $PATHTEMP
		echo -e "\033[41m\033[30m [*] НАЧАЛО СКАЧИВАНИЯ ПРОГРАММЫ \033[0m"
		wget -q $DOWNLINK 
		echo -e "\033[41m\033[30m [+] СКАЧИВАНИЕ ЗАВЕРШЕНО \033[0m"
		echo -e "\033[41m\033[30m [*] НАЧАЛО РАСПАКОВКИ АРХИВА \033[0m"
		#unzip -j $NAMEZIP.zip \*.py -d $PATHTEMP # распаковываем только .py файлы и не обращаем внимание на вложенные папки
		unzip -j $NAMEZIP.zip -d $PATHTEMP # распаковываем все не обращая внимания на вложенные папки (-j)
		echo -e "\033[41m\033[30m [+] РАСПАКОВКА АРХИВА ЗАВЕРШЕНА \033[0m"
		cd /usr/bin
		mkdir $SETDIR
		echo -e "\033[41m\033[30m [+] СОЗДАНА РАБОЧАЯ ДИРЕКТОРИЯ ПРОГРАММЫ \033[0m"
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
		#rm -Rv $PATHTEMP
		echo -e "\033[41m\033[30m [+] УДАЛЕНИЕ ВРЕМЕННЫХ ФАЙЛОВ ЗАВЕРШЕНО \033[0m"
		# --------------------------------------------
		echo -e "\033[42m\033[30m [+] УСТАНОВКА ПРОГРАММЫ ЗАВЕРШЕНА \033[0m"
		echo
		echo -e "\033[42m\033[30m Желаете создать ярлык запуска на рабочем столе? \033[0m"
		echo -n "         Создать (да/нет): "
		read STARTPAR

		if [[ $STARTPAR = да ]]
		then
			ln -s $PATHINST/$NAMEAPP.desktop $PATHDESKTOP
			echo -e "\033[41m\033[30m [+] ЯРЛЫК СОЗДАН НА РАБОЧЕМ СТОЛЕ \033[0m"
		else
			echo -e "\033[41m\033[30m [!] ЯРЛЫК НЕ СОЗДАН \033[0m"
		fi

	else
		echo -e "\033[41m\033[30m >>>>>>> Программа уже установлена!!! <<<<<<< \033[0m"
		echo -n "         Удалить (да/нет): "
		read DELPAR

		if [[ $DELPAR = да ]]
		then
			rm -Rv $PATHINST
			rm -v $PATHICO/$NAMEICO.ico
			echo -e "\033[41m\033[30m [+] ПРОГРАММА ПОЛНОСТЬЮ УДАЛЕНА \033[0m"
		else
			echo -e "\033[41m\033[30m [!] РАБОТА ПРОГРАММЫ ЗАВЕРШЕНА \033[0m"
			exit
		fi
	fi
fi