#!/bin/bash

# Gerar Deploy: lê um arquivo "lista.txt" com a hierarquia de arquivos e pastas, e cria um diretório "deploy" com o conteúdo
# OBS: Via GIT, use o seguinte comando para gerar um txt com o "diff" entre os commits:
#     git diff --name-only SHA1-de SHA1-para > lista.txt

# Declarar variáveis iniciais
URL_PATH="./"
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

echo "Lendo arquivos de 'lista.txt'"
ARR_LIST_PATH=`grep -o "\(.*/\)" lista.txt`

echo "Criando diretórios"
for line in $ARR_LIST_PATH; do test -d deploy/$line || mkdir -p deploy/$line ; done

echo "Copiando o DEPLOY"
for line in $(cat lista.txt); do cp -f $URL_PATH$line deploy/$line ; done 

echo "feito!!"

# FIM