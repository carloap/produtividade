#!/bin/bash

# Rode este shell dentro da pasta do projeto
# Com o arquivo "deploy_list.txt", será criado um diretório "deploy" com os arquivos e as estruturas de pastas definidas para subir ao ftp

# 1) Criar uma lista de arquivos para subir a partir do DIFF entre commits do GIT > "deploy_list.txt"
#git diff --name-only SHA1-de SHA1-para > deploy_list.txt

# 2) Ler arquivo "deploy_list.txt" e extrair os diretórios
grep -o "\(.*/\)" deploy_list.txt > deploy_list_out.txt

# 3) Testar e Criar diretórios recursivos
#test -d deploy/media/css/ || mkdir -p deploy/media/css/
for line in $(cat fdeploy_out.txt); do echo "test -d deploy/"$line" || mkdir -p deploy/"$line ; done > criar_dir.sh

chmod +x criar_dir.sh
./criar_dir.sh
rm criar_dir.sh
rm fdeploy_out.txt

# 4) Gerar lista para cópia e copiar para o diretório "deploy":
for line in $(cat deploy_list.txt); do echo "cp "$line" deploy/"$line ; done > copiar_deploy.sh

chmod +x copiar_deploy.sh
./copiar_deploy.sh
rm copiar_deploy.sh

# FIM