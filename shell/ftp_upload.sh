#!/bin/bash

# Upload FTP: lê um arquivo "lista.txt" com a hierarquia de arquivos e pastas, e envia todos os arquivos via FTP

# Dados de acesso FTP
HOST='endereco_ip_ou_hostname'
USER='username'
PASSWD='password'
DIRETORIO_REMOTO='raiz/do/ftp/'

# ######################################
# enviar arquivos em lote de intervalos, ex:
#     curl -T "img[1-1000].png" ftp://user:pass@ip/%2fdir_filepath

echo "Subindo arquivos via FTP"
for line in $(cat lista.txt); do curl -T deploy/$line "ftp://$USER:$PASSWD@$HOST/%2f$DIRETORIO_REMOTO$line" ; done 

echo "feito!!"

# FIM