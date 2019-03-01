#!/bin/bash
#
# ./make.sh
#
# Autor: Ricardo Pereira <rpdesignerfly@gmail.com>
# Site: https://github.com/rpdesignerfly/engenharia-de-software
#
#---------------------------------------------------------------------------------------------------
# Este programa gerencia projetos latex.
#---------------------------------------------------------------------------------------------------

SCRIPT_USE=$'Mode de Usar: speed-latex [comandos: -p|-t|-c|-o|-f|-d [valores]
Use speed-latex -h|--help para mais informações';

SCRIPT_HELP=$'Speed Latex
Copyright (c) 2018-2019 Ricardo Pereira Dias <rpdesignerfly@gmail.com>
Mode de Usar: speed-latex [comandos: -p|-t|-c|-o|-f|-d [valores]
-----------------------------------------------------------------------------------------
Comandos disponíveis:
    Criar novos projetos latex:
    -p|--project=nome-do-projeto
    -t|--type=article|book|letter|report
    Compilar projetos existentes:
    -c|--compile="nome-do-projeto"
    -o|--output="caminho/para/salvar/o/documento.pdf"
    -f|--format="pdf"
    Excluir projetos:
    -d|--delete="caminho/para/o/diretório/do/projeto"
    Ajuda:
    -h|--help
';

# variáveis padrões
libs_dir="/usr/share/speed-latex";
work_dir="$HOME/.speed-latex/temp";
curr_dir="$PWD";
devel_mode='no';

# parâmetros padrões
project_create='none';
project_type='article';
project_compile='none';
project_output='none';
project_format='pdf';
project_delete='none';
help='none';

# ----------------------------------------------------------------------------------------------------------------------
# NORMALIZA OS PARÂMETROS PASSADOS
# ----------------------------------------------------------------------------------------------------------------------


declare -A params; # cria um array vazio
salt="no"; # para controlar os parâmetros posicionais
long_empty="no"; # para controlar se o último parâmetro foi expandido e vazio
index=0; # para controlar o indice do array

for option in "$@"
do

    # parâmetros minimalistas não devem conter atribuição (=)
    if [ "${option:0:2}" != "--" ] && [ "${option:0:1}" == "-" ] && [[ $option == *"="* ]]; # contem atribuição
    then

        option_key=$(echo $option | cut -d \= -f 1);
        option_value=$(echo $option | cut -d \= -f 2);
        echo "O formato \"$option\" é inválido. Tente $option_key $option_value ";
        exit 1; #erro

    fi

    # parâmetro de atribuição
    if [[ $option == *"="* ]]; then

        let "x = x +1"; # avança o indice

        option_key=$(echo $option | cut -d \= -f 1);
        option_key=${option_key#--*};
        option_value="${option#*=}";
        params["$x"]="$option_key=$option_value";

        salt="no"; # zera o salt
        long_empty='no'; # zera o longo vazio
        continue;

    fi

    # parâmetro de atribuição sem valor
    if [ "${option:0:2}" == "--" ]; then

        let "x = x +1"; # avança o indice

        option_key=${option#-*}; # remove o '-'
        option_value="yes"; # o valor será 'yes'

        salt="no"; # zera o salt
        long_empty="$option_key";
        continue;

    fi

    # parâmetro de posicionamento
    if [ "${option:0:1}" == "-" ]; then

        let "x = x +1"; # avança o indice

        option_key=${option#-*}; # remove o '-'
        option_value="yes"; # por padrão, o valor será 'yes'
        params["$x"]="$option_key=$option_value";

        # na proxima iteração, verifica se o valor foi setado explicitamente
        salt="yes";
        long_empty='no'; # zera o longo vazio
        continue;

    fi

    # ultima iteração foi um parâmetro de posicionamento
    if [ "$salt" = "yes" ]; then

        option_value="$option";
        params["$x"]="${option_key}=${option_value}";
        salt="no";
        long_empty='no'; # zera o longo vazio

        continue;
    fi

    if [ "$long_empty" != 'no' ]; then

        echo "O formato \"$long_empty $option\" é inválido. Tente $long_empty=$option";
        exit 1; #erro

    else

        option_key=$(echo $option | cut -d \= -f 1);
        option_value=$(echo $option | cut -d \= -f 2);
        echo "O parâmetro $option é inválido.";
        exit 1; #erro
    fi

done;

# ----------------------------------------------------------------------------------------------------------------------
# PARSEAMENTO DOS PARÂMETROS
# ----------------------------------------------------------------------------------------------------------------------

for option in "${params[@]}";
do

    # option_key=$(echo $option | cut -d \= -f 1);
    # option_value=$(echo $option | cut -d \= -f 2);

    case $option in

        p=*|project=*)
            project_create="${option#*=}";
        ;;

        t=*|type=*)
            project_type="${option#*=}";
        ;;

        c=*|compile=*)
            project_compile="${option#*=}";
        ;;

        o=*|output=*)
            project_output="${option#*=}";
        ;;

        f=*|format=*)
            project_format="${option#*=}";
        ;;

        d=*|delete=*)
            project_delete="${option#*=}";
        ;;

        h=*|help=*)
            help="${option#*=}";
        ;;
    esac

done;

# ----------------------------------------------------------------------------------------------------------------------
# PREPARAÇÃO DO AMBIENTE
# ----------------------------------------------------------------------------------------------------------------------

# determina se o programa está sendo executado em modo de desenvolvimento
if [ -f "$curr_dir/make.sh" ]; then

    devel_mode='yes';

    # cria o diretório temporário para testes
    if [ ! -d "$curr_dir/tests/temp" ]; then
        mkdir -p $curr_dir/tests/temp;
    fi

    # re-instala sempre as bibliotecas
    # sudo ./uninstall.sh
    # sudo ./install.sh

fi

# cria o diretório de trabalho do usuário
if [ ! -d $work_dir ]; then
    mkdir -p $work_dir;
fi

# ----------------------------------------------------------------------------------------------------------------------
# CRIAÇÃO DE PROJETOS
# ----------------------------------------------------------------------------------------------------------------------
# Possíveis variáveis:
#    $project_create
#    $project_type [ padrão = 'article' ]
# ----------------------------------------------------------------------------------------------------------------------

if [ "$project_create" != "none" ]; then

    # valida o nome especificado para o projeto
    if [[ $project_create == *"/"* ]]; then
        echo "O nome especificado para o projeto é inválido!";
        exit 1; # erro
    fi

    # determina o local de criação do projeto
    if [ "$devel_mode" = 'yes' ]; then
        project_dir=$curr_dir/tests/temp/$project_create;
    else
        project_dir=$curr_dir/$project_create;
    fi

    # cria o diretório do projeto
    if [ -d "${project_dir}" ] && [ -d "${project_dir}/libraries" ]; then
        echo "O projeto $project_create já existe!";
        exit 1; #erro
    fi

    # cria o diretório do novo projeto
    mkdir $project_dir;

    # cria as bibliotecas
    mkdir -p $project_dir/libraries;
    cp /usr/share/speed-latex/libraries/document-fonts-free.tex $project_dir/libraries/document-fonts-free.tex;
    cp /usr/share/speed-latex/libraries/document-fonts-non-free.tex $project_dir/libraries/document-fonts-non-free.tex;
    cp /usr/share/speed-latex/libraries/document-functions.tex $project_dir/libraries/document-functions.tex;
    cp /usr/share/speed-latex/libraries/document-packages.tex $project_dir/libraries/document-packages.tex;

    # cria o conteúdo
    mkdir -p $project_dir/contents;

    # cria o documento do projeto
    case $project_type in
        article)
            echo "Criando um projeto de artigo em $project_dir";
            cp /usr/share/speed-latex/templates/article/class-article.cls $project_dir/libraries/class-article.cls;
            cp /usr/share/speed-latex/templates/article/project.tex $project_dir/project.tex;
            cp /usr/share/speed-latex/templates/article/example.tex $project_dir/contents/example.tex;
            cp /usr/share/speed-latex/templates/article/cover-simple.tex $project_dir/contents/cover-simple.tex;
        ;;

        book)
            echo "Criando um projeto de livro em $project_dir";
            cp /usr/share/speed-latex/templates/book/class-book.cls $project_dir/libraries/class-book.cls;
            cp /usr/share/speed-latex/templates/book/project.tex $project_dir/project.tex;
            cp /usr/share/speed-latex/templates/book/example.tex $project_dir/contents/example.tex;
            cp /usr/share/speed-latex/templates/book/cover-simple.tex $project_dir/contents/cover-simple.tex;
        ;;

        letter)
            echo "Criando um projeto de carta em $project_dir";
            cp /usr/share/speed-latex/templates/letter/class-letter.cls $project_dir/libraries/class-letter.cls;
            cp /usr/share/speed-latex/templates/letter/project.tex $project_dir/project.tex;
            cp /usr/share/speed-latex/templates/letter/example.tex $project_dir/contents/example.tex;
            cp /usr/share/speed-latex/templates/letter/cover-simple.tex $project_dir/contents/cover-simple.tex;
        ;;

        report)
            echo "Criando um projeto de relatório em $project_dir";
            cp /usr/share/speed-latex/templates/report/class-report.cls $project_dir/libraries/class-report.cls;
            cp /usr/share/speed-latex/templates/report/project.tex $project_dir/project.tex;
            cp /usr/share/speed-latex/templates/report/example.tex $project_dir/contents/example.tex;
            cp /usr/share/speed-latex/templates/report/cover-simple.tex $project_dir/contents/cover-simple.tex;
        ;;

        *)
            echo "Tipo inválido de projeto";
            echo "Os tipos disponiveis são article|book|letter|report"
            exit 1; #erro
        ;;
    esac

    # cria as variáveis
    cp /usr/share/speed-latex/libraries/variables.tex $project_dir/variables.tex;

    # cria o diretório de assets
    mkdir -p $project_dir/assets;

    # copia o logotipo de exemplo
    cp /usr/share/speed-latex/libraries/assets/logo.eps $project_dir/assets/logo.eps;
    cp /usr/share/speed-latex/libraries/assets/readme.txt $project_dir/assets/readme.txt;

    exit 0; #ok

fi

# ----------------------------------------------------------------------------------------------------------------------
# COMPILAÇÃO
# ----------------------------------------------------------------------------------------------------------------------
# Possíveis variáveis:
#   $project_compile
#   $project_format [ padrão = 'pdf' ]
#   $project_output
# ----------------------------------------------------------------------------------------------------------------------

if [ "$project_compile" != "none" ]; then

    if [ -d "${project_compile}" ] && [ -d "${project_compile}/libraries" ] && [ -f "${project_compile}/project.tex" ]; then

        # O projeto está em um diretório especificado no parâmetro
        first_char="${project_compile:0:1}";

        if [ "/" = "$first_char" ]; then
            # Caminho absoluto:
            # /home/ricardo/projeto
            project_dir=$project_compile;

        elif [ "/" != "$first_char" ] && [ "." != "$first_char" ]; then
            # Caminho relativo
            # projeto
            project_dir=$curr_dir/$project_compile;

        elif [ "." = "$first_char" ]; then
            # Caminho relativo
            # ./projeto
            project_dir=$curr_dir/${project_compile:2};

        fi

    elif [ -z "$project_compile" ] && [ -d "${curr_dir}/libraries" ] && [ -f "${curr_dir}/project.tex" ]; then

        # O projeto está no diretório atual
        # usuário entrou no diretório do projeto e rodou o compilador
        project_dir=$curr_dir;

    else

        # projeto inválido
        echo "Não foi encontrado um projeto válido para compilar.";
        echo "Entre em um projeto válido ou especifique o caminho até ele";
        echo "Por exemplo:";
        echo "  cd /caminho/do/meu-projeto; speed-latex -c";
        echo "  cd /caminho/do/meu-projeto; speed-latex --compile";
        echo "  ou";
        echo "  speed-latex -c /caminho/do/meu-projeto";
        echo "  speed-latex --compile /caminho/do/meu-projeto";
        exit 1; #erro

    fi

    # remove barra (/) no final
    project_dir="${project_dir%/}";

    echo "Compilando o projeto $project_dir";

    # entra no diretório do projeto
    cd $project_dir;

    # compila o projeto
    latexmk -gg -pdf -halt-on-error project.tex | grep '^!.*' -A200 --color=always;

    # limpa os arquivos temporários
    # latexmk -c

    # volta para o diretório original
    if [ "$project_dir" != "$curr_dir" ]; then
        # volta para o diretório original
        cd - > /dev/null;
    fi

    if [ "$project_output" != "none" ]; then

        if [ -d "$project_output" ]; then
            project_output="$project_output/project.pdf"
        fi

        mv $project_dir/project.pdf $project_output;

    fi

    # Limpa os diretórios de gráficos
    rm $project_dir/assets/*converted-to.pdf 2> /dev/null;
    # Limpa o diretório da biblioteca
    rm $project_dir/libraries/*.aux 2> /dev/null;
    # Limpa o diretório do projeto
    rm $project_dir/*_.pdf 2> /dev/null;
    rm $project_dir/*.acn 2> /dev/null;
    rm $project_dir/*.acr 2> /dev/null;
    rm $project_dir/*.alg 2> /dev/null;
    rm $project_dir/*.aux 2> /dev/null;
    rm $project_dir/*.bbl 2> /dev/null;
    rm $project_dir/*.blg 2> /dev/null;
    rm $project_dir/*.cb 2> /dev/null;
    rm $project_dir/*.cb2 2> /dev/null;
    rm $project_dir/*.dvi 2> /dev/null;
    rm $project_dir/*.fdb_latexmk 2> /dev/null;
    rm $project_dir/*.fls 2> /dev/null;
    rm $project_dir/*.fmt 2> /dev/null;
    rm $project_dir/*.fot 2> /dev/null;
    rm $project_dir/*.glg 2> /dev/null;
    rm $project_dir/*.glo 2> /dev/null;
    rm $project_dir/*.gls 2> /dev/null;
    rm $project_dir/*.glsdefs 2> /dev/null;
    rm $project_dir/*.gz 2> /dev/null;
    rm $project_dir/*.idx 2> /dev/null;
    rm $project_dir/*.ilg 2> /dev/null;
    rm $project_dir/*.ind 2> /dev/null;
    rm $project_dir/*.ist 2> /dev/null;
    rm $project_dir/*.lof 2> /dev/null;
    rm $project_dir/*.log 2> /dev/null;
    rm $project_dir/*.lol 2> /dev/null;
    rm $project_dir/*.loe 2> /dev/null;
    rm $project_dir/*.lot 2> /dev/null;
    rm $project_dir/*.maf 2> /dev/null;
    rm $project_dir/*.mtc 2> /dev/null;
    rm $project_dir/*.mtc0 2> /dev/null;
    rm $project_dir/*.nav 2> /dev/null;
    rm $project_dir/*.nlo 2> /dev/null;
    rm $project_dir/*.out 2> /dev/null;
    rm $project_dir/*.pdfsync 2> /dev/null;
    rm $project_dir/*.ps 2> /dev/null;
    rm $project_dir/*.snm 2> /dev/null;
    rm $project_dir/*.synctex.gz 2> /dev/null;
    rm $project_dir/*.toc 2> /dev/null;
    rm $project_dir/*.vrb 2> /dev/null;
    rm $project_dir/*.xdy 2> /dev/null;
    rm $project_dir/*.tdo 2> /dev/null;

    exit 0; #ok

fi

# nenhuma operação executada!
echo "Parâmetros inválidos!";
echo $SCRIPT_USE;
exit 1; #erro
