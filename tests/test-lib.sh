#!/bin/bash
#
# ./test-lib.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Esta é uma biblioteca de funções para testes de unidade
#---------------------------------------------------------------------------------------------------

function assert_file_exists()
{
    if [ -f "$1" ]; then
        exit 1;
    fi

}

function assert_file_not_exists()
{
    if [ ! -f "$1" ]; then
        exit 1;
    fi

}
