#!/bin/bash

# Query que gera um DUMP incrimental de TANTOS em TANTOS registros, por um tempo limite

# Dados de acesso ao banco
MYSQL_H="HOST"
MYSQL_U="USERNAME"
MYSQL_P="PASSWORD"

# Variáveis interna
Q_POSICAO=0
Q_LIMITE=150
F_NOME_ARQUIVO="DUMP_CLIENTES"

# ######################################

# QUERY: Tabela ou Select para extração de dados
Q_QUERY="select * from saiyans s where s.power_level >= 8000
limit 0, 150;"

# ######################################

# Limpar o arquivo de saída CSV para começar as novas gravações
> $F_NOME_ARQUIVO".csv"

# Verifica tamanho do arquivo de saída
TAMANHO_ARQ=$(wc -c $F_NOME_ARQUIVO".csv" | egrep -o "[0-9]+")
COMPARA_TAMANHO_ARQ=0

# Executa a rotina por um tempo limitado
TEMPOFINAL=$((SECONDS+7200)) # o loop vai durar 7200 segundos (7200seg = 2horas)
while [ $SECONDS -lt $TEMPOFINAL ]; do

    sleep 2 # pausa para não onerar o banco

    echo "Offset: "$Q_POSICAO
    echo "Tamanho de saída: "$TAMANHO_ARQ
    
    Q_QUERY=$(echo "${Q_QUERY}" | grep -Ev "limit") # elimina por expressão regular, a linha que contém "limit" para inserir manualmente, pois o "sed" não funciona como esperado nos BSDs
    Q_QUERY=$Q_QUERY"
        limit ${Q_POSICAO}, ${Q_LIMITE};"

    #echo $Q_QUERY # imprime a query como debug

    if [ $Q_POSICAO -gt 0 ]; then
        mysql -h ${MYSQL_H} -u ${MYSQL_U} -p${MYSQL_P} ecommerce2 --execute="${Q_QUERY}" | sed -n '1!p' >> $F_NOME_ARQUIVO".csv" # appenda o resultado num arquivo, eliminando a primeira linha com "sed"
    else
        mysql -h ${MYSQL_H} -u ${MYSQL_U} -p${MYSQL_P} ecommerce2 --execute="${Q_QUERY}" >> $F_NOME_ARQUIVO".csv"
    fi
    
    # Verifica novamente o tamanho do arquivo de saída
    TAMANHO_ARQ=$(wc -c $F_NOME_ARQUIVO".csv" | egrep -o "[0-9]+")

    # Se o tamanho do arquivo não for maior que o tamanho no último loop, chegou ao fim
    if ! [ $TAMANHO_ARQ -gt $COMPARA_TAMANHO_ARQ ]; then 
        echo "Encerrando o loop..."
        break
    fi

    # define o tamanho do arquivo para encerramento da rotina
    COMPARA_TAMANHO_ARQ=$TAMANHO_ARQ

    # autoincrement +150
    Q_POSICAO=$(expr $Q_POSICAO + $Q_LIMITE)

done

# SAIDA
echo "TERMINANDO..."

