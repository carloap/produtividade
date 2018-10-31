#!/bin/bash

# ######################################
## Obter os arquivos diferentes entre branchs
# ######################################

## Executa o script a partir do diretório atual
URL_PATH="caminho/do/projeto"
BRANCH_NAME="nomeDoBranchDeDesenvolvimento"

## Configurar parâmetros
while getopts ":b:" opt; do
	case $opt in
		-)
			echo "TODO...";;
		b)
			BRANCH_NAME=$2
			shift
			;;
	esac
done

## Acessa o diretório
cd $URL_PATH

## Remove diretório de deploy
rm -rf deploy_r

echo "Criando deploy -> 'deploy_r/' "

## GERA LISTA DE COMMITS
IFS=$'\n' # split para quebra de linha
set -o noglob
LISTA_COMMITS=($(git log --oneline --no-merges --pretty=format:"%h" master..${BRANCH_NAME}))

for (( index=0; index < ${#LISTA_COMMITS[@]}; index++ ))
do
 #if [ -n "${LISTA_COMMITS[index+1]}" ]; then
  #LISTA_NOMES=`git diff --name-only ${LISTA_COMMITS[index]}..${LISTA_COMMITS[index+1]}`
  LISTA_NOMES=`git show --pretty="" --name-only ${LISTA_COMMITS[index]}`
  var="$var
$LISTA_NOMES"
 #fi
done 

echo "Lista de Arquivos: "
echo "$var" | xargs -n1 | sort -u