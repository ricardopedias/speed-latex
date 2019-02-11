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

libs_dir="/usr/share/speed-latex";
work_dir="$HOME/.speed-latex/temp";
curr_dir="$PWD";

# determina se o programa está sendo executado em desenvolvimento
devel_mode='no';
if [ -f "$curr_dir/make.sh" ]; then
    devel_mode='yes';
fi

# cria o diretório temporário para testes
if [ ! -d "$curr_dir/tests/temp" ] && [ "$devel_mode" = "yes" ]; then
    mkdir -p $curr_dir/tests/temp;
fi

# cria o diretório de trabalho do usuário
# se ele não existir
if [ ! -d $work_dir ]; then
    mkdir -p $work_dir;
fi

SCRIPT_USE=$'Mode de Usar: speed-latex <comando> <projeto|file.tex> [parâmetros]
Use speed-latex --help para mais informações';

SCRIPT_HELP=$'GIT Tools
Mode de Usar: speed-latex <comando> <projeto|file.tex> [parâmetros]
-----------------------------------------------------------------------------------------
Comandos disponíveis:
    -p|--project "nome-do-projeto" : Cria um novo projeto latex
    -c|--compile "arquivo latex-project.tex" : compila o projeto especificado
    -h|--help : Exibe o texto de ajuda
    ';

document_type='article';

# opções solitárias
for param in "$@"
do
    case $param in

        -h|--help)
            echo "$SCRIPT_USE";
            exit 1;
        ;;

        -a|--article)
            document_type='article';
        ;;

        -b|--book)
            document_type='book';
        ;;

        -l|--letter)
            document_type='letter';
        ;;

        -r|--report)
            document_type='report';
        ;;

    esac

done;

# cria um novo projeto latex
if [ "$1" = "-p" ] || [ "$1" = "--project" ]; then

    if [ -z "$2" ] && [ "$devel_mode" = 'no' ]; then

        # Parametro invalido
        echo "É obrigatório especificar o nome do projeto";
        echo "Ex: speed-latex $1 \"meu-projeto\"";
        exit 1;

    fi

    # valida o nome especificado para o projeto
    if [[ $2 == *"/"* ]]; then
        echo "O nome especificado para o projeto é inválido!";
        exit;
    fi

    if [ "$devel_mode" = 'yes' ]; then
        project_dir=$curr_dir/tests/temp/$2;
    else
        project_dir=$curr_dir/$2;
    fi

    # cria o diretório do projeto
    if [ -d "${project_dir}" ] && [ -d "${project_dir}/libraries" ]; then
        echo "O projeto $2 já existe!";
        exit 1;
    fi

    mkdir $project_dir;

    # cria as bibliotecas
    mkdir -p $project_dir/libraries;
    cp /usr/share/speed-latex/libraries/document-fonts-free.tex $project_dir/libraries/document-fonts-free.tex;
    cp /usr/share/speed-latex/libraries/document-fonts-non-free.tex $project_dir/libraries/document-fonts-non-free.tex;
    cp /usr/share/speed-latex/libraries/document-functions.tex $project_dir/libraries/document-functions.tex;
    cp /usr/share/speed-latex/libraries/document-packages.tex $project_dir/libraries/document-packages.tex;

    # cria o conteudo
    mkdir -p $project_dir/contents;

    # cria o documento do projeto
    case $document_type in
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
    esac

    # cria as variáveis
    cp /usr/share/speed-latex/libraries/variables.tex $project_dir/variables.tex;

    # cria o diretório de assets
    mkdir -p $project_dir/assets;
    # copia o logotipo de exemplo
    cp /usr/share/speed-latex/libraries/assets/logo.eps $project_dir/assets/logo.eps;
    cp /usr/share/speed-latex/libraries/assets/readme.txt $project_dir/assets/readme.txt;

fi

# compila um projeto latex existente
if [ "$1" = "-c" ] || [ "$1" = "--compile" ]; then

    if [ ! -z "$2" ] && [ -d "${2}" ] && [ -d "${2}/libraries" ] && [ -f "${2}/project.tex" ]; then

        # O projeto está em um diretório especificado
        first_char="${2:0:1}";

        if [ "/" = "$first_char" ]; then
            # Caminho absoluto:
            # /home/ricardo/projeto
            project_dir=$2;

        elif [ "/" != "$first_char" ] && [ "." != "$first_char" ]; then
            # Caminho relativo
            # projeto
            project_dir=$curr_dir/$2;

        elif [ "." = "$first_char" ]; then
            # Caminho relativo
            # ./projeto
            project_dir=$curr_dir/${2:2};

        else
            project_dir=$2;
        fi

    elif [ -z "$2" ] && [ -d "${curr_dir}/libraries" ] && [ -f "${curr_dir}/project.tex" ]; then

        # O projeto está no diretório atual
        project_dir=$curr_dir;

    else

        # projeto inválido
        echo "Não foi encontrado um projeto válido para compilar.";
        echo "Entre em um projeto válido ou especifique o caminho até ele";
        echo "Por exemplo:";
        echo "  cd /caminho/do/meu-projeto; speed-latex $1";
        echo "  ou";
        echo "  speed-latex $1 /caminho/do/meu-projeto";
        exit 1;

    fi

    # remove barra (/) no final
    project_dir="${project_dir%/}";

    echo "Compilando o projeto $project_dir";

    # entra no diretório do projeto
    cd $project_dir;
    latexmk -pdf -halt-on-error project.tex | grep '^!.*' -A200 --color=always;
    if [ "$project_dir" != "$curr_dir" ]; then
        # volta para o diretório original
        cd -;
    fi

    if [ -z "$3" ] && [ -z "$4" ]; then

        if [ "-o" = "$3" ] || [ "--output" = "$3" ]; then

            cp $project_dir/project.pdf $4;

        fi

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

fi
