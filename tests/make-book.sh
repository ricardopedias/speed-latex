#!/bin/bash
#
# ./devel.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Este programa executa a re-instalação antes de executar o comando
#---------------------------------------------------------------------------------------------------

# nome do teste
echo "Teste de criação e compilação de livros";

# rotina de execução
{

    ./make.sh -p test-book --type="book";
    ./make.sh -c tests/temp/test-book;

} > tests/temp/output.txt 2> tests/temp/output.txt

# rotina de asserção
if [ -f 'tests/temp/test-book/project.pdf' ]; then
    exit 0;
fi

exit 0;
