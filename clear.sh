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

path="$1";

# Limpa os diretórios de gráficos
rm $path/*converted-to.pdf 2> /dev/null;

# Limpa o diretório do projeto
rm $path/*_.pdf 2> /dev/null;
rm $path/*.acn 2> /dev/null;
rm $path/*.acr 2> /dev/null;
rm $path/*.alg 2> /dev/null;
rm $path/*.aux 2> /dev/null;
rm $path/*.bbl 2> /dev/null;
rm $path/*.blg 2> /dev/null;
rm $path/*.cb 2> /dev/null;
rm $path/*.cb2 2> /dev/null;
rm $path/*.dvi 2> /dev/null;
rm $path/*.fdb_latexmk 2> /dev/null;
rm $path/*.fls 2> /dev/null;
rm $path/*.fmt 2> /dev/null;
rm $path/*.fot 2> /dev/null;
rm $path/*.glg 2> /dev/null;
rm $path/*.glo 2> /dev/null;
rm $path/*.gls 2> /dev/null;
rm $path/*.glsdefs 2> /dev/null;
rm $path/*.gz 2> /dev/null;
rm $path/*.idx 2> /dev/null;
rm $path/*.ilg 2> /dev/null;
rm $path/*.ind 2> /dev/null;
rm $path/*.ist 2> /dev/null;
rm $path/*.lof 2> /dev/null;
rm $path/*.log 2> /dev/null;
rm $path/*.lol 2> /dev/null;
rm $path/*.loe 2> /dev/null;
rm $path/*.lot 2> /dev/null;
rm $path/*.maf 2> /dev/null;
rm $path/*.mtc 2> /dev/null;
rm $path/*.mtc0 2> /dev/null;
rm $path/*.nav 2> /dev/null;
rm $path/*.nlo 2> /dev/null;
rm $path/*.out 2> /dev/null;
rm $path/*.pdfsync 2> /dev/null;
rm $path/*.ps 2> /dev/null;
rm $path/*.snm 2> /dev/null;
rm $path/*.synctex.gz 2> /dev/null;
rm $path/*.toc 2> /dev/null;
rm $path/*.vrb 2> /dev/null;
rm $path/*.xdy 2> /dev/null;
rm $path/*.tdo 2> /dev/null;
