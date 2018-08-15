#!/bin/bash

# Backup FTP: lê um arquivo "lista.txt" com a hierarquia de arquivos e pastas, baixa via FTP o conteúdo para um diretório "bkp"

# Dados de acesso FTP
HOST='endereco_ip_ou_hostname'
USER='username'
PASSWD='password'
DIRETORIO_REMOTO='raiz/do/ftp/'

# ######################################
echo "Lendo arquivos de 'lista.txt'"
ARR_LIST_PATH=`grep -o "\(.*/\)" lista.txt`

echo "Criando diretórios"
for line in $ARR_LIST_PATH; do test -d bkp/$line || mkdir -p bkp/$line ; done

echo "Baixando arquivos via FTP"
for line in $(cat lista.txt); do curl -o bkp/$line "ftp://$USER:$PASSWD@$HOST/%2f$DIRETORIO_REMOTO$line" ; done 

echo "feito!!"

# FIM