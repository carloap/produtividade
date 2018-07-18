#!/bin/bash

# Declarar variáveis iniciais
URL_PATH=""
ARR_LIST_PATH=""

# ######################################
# Configura atributos passados pelo shell 
# check > https://stackoverflow.com/questions/402377/using-getopts-in-bash-shell-script-to-get-long-and-short-command-line-options/7680682#7680682

while getopts ":p:" opt; do
	case $opt in
		-)
			echo "não posso validar o 'long' agora";;
		p)
			URL_PATH=$2
			shift
			;;
	esac
done

echo "URL_PATH ( -p ) = $URL_PATH"

echo "Extraindo lista recursiva do arquivo 'deploy_list.txt'"
ARR_LIST_PATH=`grep -o "\(.*/\)" deploy_list.txt`
echo "feito!"

echo "Criando diretórios"
for line in $ARR_LIST_PATH; do test -d deploy/$line || mkdir -p deploy/$line ; done
echo "feito!"

echo "Copiando o DEPLOY"
for line in $(cat deploy_list.txt); do cp -f $URL_PATH$line deploy/$line || ":" ; done 
echo "feito!!"

# FIM