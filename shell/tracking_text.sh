#! /bin/bash


## URL Origem
URL_FROM="http://dontpad.com/399cfdb1b09a8737714654d424cecf4c/from" # teste :) # não me responsabilizo pelo seu conteúdo meu chapa

## URL Destino
URL_TO="http://dontpad.com/399cfdb1b09a8737714654d424cecf4c/to"

## Cookie de controle de sessão
COOKIE="key=value"


###########################################
## Obtém conteúdo de origem
CONTENT_FROM=$(curl $URL_FROM --cookie $COOKIE --silent --show-error )

## Extrai a mensagem da origem
MESSAGE_FROM=$(echo -e "$CONTENT_FROM" | sed -z 's/\n/\\n/g' | grep -o '<textarea.*</textarea>' | sed 's/<textarea.*">\|<\/textarea>//g' | sed 's/\\n/\n/g')
HASH_CONTENT_FROM=$(echo -e "$MESSAGE_FROM" | sha1sum | awk '{print $1}')
#echo "$MESSAGE_FROM"


###########################################
## Enviar dados para destino
f_send_data ()
{
    #echo "enviando dados... "
    curl -XPOST "$URL_TO" --data "text=$1" --cookie "$COOKIE" --silent > /dev/null
}
## Executa a primeira chamada de envio...
f_send_data "$MESSAGE_FROM"


###########################################
## LOOP - Verifica sempre que houver mudança de HASH para envio de novas mensagens
while [ true ]
do
    sleep 0.5
    ## Obtém novamente o conteúdo de origem
    CONTENT_FROM=$( curl $URL_FROM --cookie $COOKIE --silent --show-error )

    ## Extrai novamente a mensagem da origem
    MESSAGE_FROM=$(echo -e "$CONTENT_FROM" | sed -z 's/\n/\\n/g' | grep -o '<textarea.*</textarea>' | sed 's/<textarea.*">\|<\/textarea>//g' | sed 's/\\n/\n/g')
    TMP_HASH=$(echo $MESSAGE_FROM | sha1sum | awk '{print $1}')
    
    ## Compara por HASH se houve atualização na mensagem
    if test $TMP_HASH != $HASH_CONTENT_FROM
    then
        ## Atualiza HASH sempre que houver mensagem nova
        HASH_CONTENT_FROM=$TMP_HASH
        # Envia dados
        f_send_data "$MESSAGE_FROM"

    fi

done