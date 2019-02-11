#!/bin/bash
#
# ./install.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Este programa efetua a instalação do speed-latex no sistema
#

echo "------------------------------------------------------------------------";
echo "Configurando as dependencias";
echo "------------------------------------------------------------------------";
sudo apt-get install -y \
texlive texlive-latex-extra texlive-lang-portuguese \
texlive-fonts-recommended \
texlive-extra-utils texlive-generic-extra texlive-lang-portuguese \
texlive-latex-extra texlive-pictures \
texlive-plain-extra texlive-publishers texlive-science-doc texlive-science;

root_dir=$PWD;

# copia os arquivos
echo "------------------------------------------------------------------------";
echo "Configurando as bibliotecas";
echo "------------------------------------------------------------------------";
if [ -d "/usr/share/speed-latex" ]; then
    # remove instalações anteriores
    sudo rm -Rf /usr/share/speed-latex
fi
sudo cp -rf $root_dir /usr/share/speed-latex
#sudo chmod 777 -Rf /usr/share/speed-latex/*

# cria o executável global
if [ ! -h "/usr/bin/speed-latex" ]; then
    echo "------------------------------------------------------------------------";
    echo "Configurando o executável";
    echo "------------------------------------------------------------------------";
    sudo ln -s /usr/share/speed-latex/make.sh /usr/bin/speed-latex
fi

echo "Pronto! Speed Latex instalado";
