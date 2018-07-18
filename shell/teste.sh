#! /bin/bash

# ######################################
# Versão para Linux Debian

# Declarar variáveis iniciais
URL_PATH="none"


# ::::: IMPORTANTE :::::
# OBS: There is a shell tool getopt which is another program, not a bash builtin. 
# The GNU implementation of getopt(3) (used by the command-line getopt(1) on Linux) supports parsing long options.

# # Analisar argumentos passados em linha de comando com 'getopt'
# params=$(getopt -o p: -l path: --name "$0" -- "$@")
# #if [ $? != 0 ] ; then echo "Informe o caminho ao diretório do projeto." >&2 ; exit 1 ; fi
# eval set -- "$params"

# # Extrair opções dos argumentos
# while true ; do
# 	case "$1" in 
# 		-p|--path)
# 			echo "pathing..."
# 			URL_PATH=$2
# 			shift
# 			;;
# 		--) shift ; break ;;
# 		* ) echo "erro" ; exit 1 ;;
# 	esac
# done

# ######################################
# Versão para MAC

# echo "testando segunda forma"

while getopts ":p:" opt; do
	case $opt in
		-)
			# check > https://stackoverflow.com/questions/402377/using-getopts-in-bash-shell-script-to-get-long-and-short-command-line-options/7680682#7680682
			echo "não posso validar o 'long' agora";;
		p)
			URL_PATH=$2
			shift
			;;
	esac
done

echo "URL_PATH = $URL_PATH"
