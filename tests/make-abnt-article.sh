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

# inclui a biblioteca com as ferramentas de teste
. ./tests/test-lib.sh

# nome do teste
echo "Teste de criação e compilação de Artigo Científico";

# rotina de execução
{

    ./speedlatex.sh -p test-abnt-article --type="abnt-article"; # cria um novo projeto latex
    ./speedlatex.sh -c tests/temp/test-abnt-article; # compila o projeto
    cp tests/temp/test-abnt-article/project.pdf project/abnt-article.pdf;

} > tests/temp/output.txt 2> tests/temp/output.txt;

# rotina de asserção
assert_file_exists 'tests/temp/test-abnt-article/project.pdf';

exit 1; # ok, todos os testes funcionaram
