#!/bin/bash

# Rode este shell dentro da pasta do projeto
# Com o arquivo "fdeploy.txt", será criado um diretório "bkp" 
# com os arquivos e as estruturas de pastas baixados via ftp

# Dados de acesso FTP
HOST='endereco_ip_ou_hostname'
USER='username'
PASSWD='password'
DIRETORIO_REMOTO='raiz/do/ftp/'

# Ler arquivo "fdeploy.txt" e extrair os diretórios
grep -o "\(.*/\)" fdeploy.txt > fdeploy_out.txt

# BACKUP DE ARQUIVOS
# Testar e Criar diretórios recursivos de BKP
for line in $(cat fdeploy_out.txt); do echo "test -d bkp/"$line" || mkdir -p bkp/"$line ; done > criar_dir_bkp.sh

chmod +x criar_dir_bkp.sh
./criar_dir_bkp.sh
rm criar_dir_bkp.sh
rm fdeploy_out.txt

# Gerar lista para baixar do FTP:
for line in $(cat fdeploy.txt); do echo 'curl -o bkp/'$line' "ftp://'$USER':'$PASSWD'@'$HOST'/%2f'$DIRETORIO_REMOTO'/'$line'"' ; done > copiar_arquivos_bkp.sh

chmod +x copiar_arquivos_bkp.sh
./copiar_arquivos_bkp.sh
rm copiar_arquivos_bkp.sh

# FIM
