#!/bin/bash
#
# ./unit.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Este programa executa os testes de unidade
#---------------------------------------------------------------------------------------------------

# cores
RED='\033[0;31m';
GREEN='\033[0;32m';
NORMAL='\033[0m';

# reinstala as bibliotecas
sudo ./uninstall.sh > /dev/null;
sudo ./install.sh > /dev/null;

root_path="$PWD";
# tests_list=$(ls tests/*.sh);

# tests_list=$(echo "
#     tests/make-abnt-slides.sh
#     tests/make-abnt-technical-report.sh
#     tests/make-common-book.sh
#     tests/make-common-document.sh
# ");

tests_list=$(echo "
    tests/make-abnt-academic-work.sh
    tests/make-abnt-article.sh
    tests/make-abnt-research-project.sh
    tests/make-common-book.sh
    tests/make-common-letter.sh
");


echo "==========================================================";
echo "Executando testes de unidade";
echo "----------------------------------------------------------";

for test in $tests_list; do

    if [ "$test" = "tests/test-lib.sh" ]; then
        continue;
    fi

    # reseta a localização
    cd $root_path;
    rm -Rf tests/temp/*

    if [ ! -d tests/temp ]; then
        mkdir -p tests/temp;
    fi

    # cria o arquivo de saida
    touch tests/temp/output.txt;

    # executa o teste
    result_text=$(./$test);
    result_sign="$?";

    if [ "$result_sign" = "1" ]; then
        echo -e "${GREEN}[Ok] $result_text${NORMAL}";
    else
        echo -e "${RED}[Fail] $result_text${NORMAL}";
        echo "----------------------------------------------------------";
        echo "Output: ";
        cat tests/temp/output.txt;
    fi

    # remove arquivos temporários gerados pelos testes
    rm -Rf tests/temp/*

    # remove os arquivos temporaŕios no projeto do pacote
    sudo ./clear.sh project
    sudo ./clear.sh project/assets
    sudo ./clear.sh project/libraries

done

echo "==========================================================";
