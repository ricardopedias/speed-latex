%===================================================================================================
% Autor             : Ricardo Pereira Dias <rpdesignerfly@gmail.com>
% Data de criação   : 29 de Janeiro de 2019
% Referencias       : https://pt.overleaf.com/learn
%                     https://texblog.org/code-snippets/beamer-presentation/
%                     https://aprendolatex.wordpress.com/2007/06/09/seccoes-em-latex/
%                     https://pt.wikibooks.org/wiki/Latex/Se%C3%A7%C3%B5es
% --------------------------------------------------------------------------------------------------
% Esta classe configura documentos no formato 'letter'.
% Cartas não possuem nenhum tipo de seção capítulos (\part, \chapter, \section...)
%===================================================================================================

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

% Carrega a classe de formatação para o tipo 'article'.
\LoadClass[a4paper,12pt]{letter}[2000/05/19 v1.4b Standard LaTeX document class]
\RequirePackage[utf8]{inputenc}
\RequirePackage[portuguese,brazil]{babel}
\RequirePackage{amsmath,amssymb,amsfonts,float,fancyhdr}

% --------------------------------------------------------------------------------------------------
% LAYOUT
% --------------------------------------------------------------------------------------------------

% \setlength{\topmargin}{-7mm}
% \setlength{\oddsidemargin}{0mm}
% \setlength{\evensidemargin}{0mm}
% \setlength{\headheight}{6mm}

% Área de texto
\setlength{\textheight}{235mm}
\setlength{\textwidth}{160mm}

% --------------------------------------------------------------------------------------------------
% TEMPLATE PADRÃO
% --------------------------------------------------------------------------------------------------

\pagestyle{fancy}


\fancypagestyle{plain}{

    % Limpa todos os campos do cabeçalho e rodapé
    \fancyhf{}

    % ----------------------------------------------------------------------------------------------
    % CABEÇALHOS
    % ----------------------------------------------------------------------------------------------

    % Cabeçalhos Pares
    \fancyhead[LE]{
    }
    % Cabeçalhos Ímpares
    \fancyhead[RO]{
    }

    % Espaço entre o texto e a linha separadora
    \renewcommand{\headrulewidth}{0pt}

    % ----------------------------------------------------------------------------------------------
    % RODAPÉS
    % ----------------------------------------------------------------------------------------------
    \fancyfoot[C]{
        \color{footer_text}
        \sffamily \fontsize{10pt}{10pt} \selectfont \thepage
    }

    % Espaço entre o texto e a linha separadora
    \renewcommand{\footrulewidth}{0pt}

    % ----------------------------------------------------------------------------------------------
    % PARÁGRAFOS TEXTUAIS
    % ----------------------------------------------------------------------------------------------

    % Entre linhas de 1,5
    \onehalfspacing
    % \renewcommand{\baselinestretch}{1.5}

    % Entre parágrafos de 0.3cm
    \setlength{\parskip}{0.3cm}

    % Indentação da primeira linha no parágrafo (TAB)
    \setlength{\parindent}{0.6cm}

}
