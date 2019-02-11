#!/bin/bash
#
# ./install.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Este programa efetua a remoção do speed-latex do sistema
#

if [ -h "/usr/bin/speed-latex" ] || [ -d "/usr/share/speed-latex" ]; then

    # remove o link
    if [ -h "/usr/bin/speed-latex" ]; then
        echo "Removendo o executável";
        sudo unlink /usr/bin/speed-latex
    fi

    if [ -d "/usr/share/speed-latex" ]; then
        echo "Removendo as bibliotecas";
        sudo rm -Rf /usr/share/speed-latex
    fi

    echo "Pronto! Speed Latex desinstalado";

else

    echo "Speed Latex não está instalado";

fi
