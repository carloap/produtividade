#!/bin/bash

# Rode este shell dentro da pasta do projeto com o arquivo "deploy_list.txt" contendo a lista dos arquivos afetados para subi-los via FTP

# Dados de acesso FTP
HOST='endereco_ip_ou_hostname'
USER='username'
PASSWD='password'
DIRETORIO_REMOTO='raiz/do/ftp/'

# Gerar lista para baixar do FTP:
#curl -T "img[1-1000].png" ftp://user:pass@ip/%2fdir_filepath
for line in $(cat deploy_list.txt); do echo 'curl -T "deploy/'$line'" ftp://'$USER':'$PASSWD'@'$HOST'/%2f'$DIRETORIO_REMOTO'/'$line ; done > upload_deploy.sh

chmod +x upload_deploy.sh
./upload_deploy.sh
rm upload_deploy.sh

# FIM