%===================================================================================================
% Autor             : Ricardo Pereira Dias <rpdesignerfly@gmail.com>
% Data de criação   : 29 de Janeiro de 2019
% Referencias       : https://pt.overleaf.com/learn
%                     https://texblog.org/code-snippets/beamer-presentation/
%                     https://aprendolatex.wordpress.com/2007/06/09/seccoes-em-latex/
%                     https://pt.wikibooks.org/wiki/Latex/Se%C3%A7%C3%B5es
% --------------------------------------------------------------------------------------------------
% Esta classe configura documentos no formato 'article'.
% Artigos não possuem capítulos (\chapter), tendo o topo de sua hierarquia nas seções (\section)
%===================================================================================================

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

% Carrega a classe de formatação.
\LoadClass[a4paper,12pt]{article}[2000/05/19 v1.4b Standard LaTeX document class]
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

% Novo container para páginas sem cabeçalhos ou rodapés
\newcounter{removed_pagination}
\newenvironment{clean_page}{

    \clearpage\stepcounter{removed_pagination}%
    \renewcommand{\thepage}{}%
    \thispagestyle{empty}

}

% Determina o valor para pular as primeiras páginas (capa, contra-capa, e opcionais)
% a quantidade de páginas para pular é definida em 'document-vars.tex'
\newcommand{\subtractPages}{1}
\newcommand\skipPages{ \the\numexpr (\startCountPages - 1) * -1}

\fancypagestyle{plain}{

    % Limpa todos os campos do cabeçalho e rodapé
    \fancyhf{}

    % ----------------------------------------------------------------------------------------------
    % CABEÇALHOS
    % ----------------------------------------------------------------------------------------------

    % Cabeçalhos Pares
    \fancyhead[LE]{
        \color{header_text}
        %\chaptertitle para colocar o capitulo no cabelaho ou rodape
        \fontsize{10}{10}\selectfont \it \projectName \hfill \it \titleDocument
    }
    % Cabeçalhos Ímpares
    \fancyhead[RO]{
        \color{header_text}
        \fontsize{10}{10}\selectfont \it \titleDocument \hfill \it \projectName
    }

    % Espaço entre o texto e a linha separadora
    \renewcommand{\headrulewidth}{0.5pt}

    % Cor da linha separadora
    \makeatletter
    % \patchcmd{\footrule}
    %   {\if@fancyplain}
    %   {\color{header_rule}\if@fancyplain}
    %   {}
    %   {}
      \xpretocmd\headrule{ \color{header_rule}  }{}{ \PatchFailed }
    \makeatother

    % ----------------------------------------------------------------------------------------------
    % RODAPÉS
    % ----------------------------------------------------------------------------------------------

    \fancyfoot[C]{
        \color{footer_text}
        \sffamily \fontsize{10pt}{10pt} \selectfont \thepage
    }

    % Espaço entre o texto e a linha separadora
    \renewcommand{\footrulewidth}{0.5pt}

    % Cor da linha separadora
    \makeatletter
    \patchcmd{\footrule}
      {\if@fancyplain}
      {\color{footer_rule}\if@fancyplain}
      {}
      {}
    \makeatother
    % \xpretocmd\footrule{ \color{footer_rule} \relax }{}{ \PatchFailed }

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

% --------------------------------------------------------------------------------------------------
% TITULOS E SEÇÕES
% --------------------------------------------------------------------------------------------------

% Formatação das seções
\usepackage{titlesec}

% Numeração de seções nivel 1
\titleformat{\section}
    {\normalfont\Large\bfseries}{\color{section_count}\thesection.}{10pt}{}

% Numeração de seções nivel 2
\titleformat{\subsection}
      {\normalfont\large\bfseries}{\color{subsection_count}\thesubsection.}{10pt}{}

% Numeração de seções nivel 3
\titleformat{\subsubsection}
    {\normalfont\normalsize\bfseries}{\color{subsubsection_count}\thesubsubsection.}{10pt}{}

% Numeração de parágrafo (para leis)
\titleformat{\paragraph}[runin]
    {\normalfont\normalsize\bfseries}{\color{paragraph_text}\theparagraph}{1em}{}

% Numeração de subparágrafo (para leis)
\titleformat{\subparagraph}[runin]
    {\normalfont\normalsize\bfseries}{\color{paragraph_text}\thesubparagraph}{1em}{}

% Ativa até 5 níveis de numeração
\setcounter{secnumdepth}{5}

% Espaçamento das seções
% \titlespacing\section{?} = espaçamento lateral
% \titlespacing\section{x}{?}{?} = espaçamento antes e depois do texto
% Como se lê {12pt plus 4pt minus 2pt}
% '12pt' é o que gostaríamos que o espaçamento fosse.
% 'plus 4pt' significa que o TeX pode esticá-lo em no máximo 4pt.
% 'minus 2pt' significa que o TeX pode encolher no máximo 2pt.

% \titlespacing*{\chapter}     {0pt}{50pt}{40pt}
% \titlespacing*{\section}     {0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}
% \titlespacing*{\subsection}   {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
% \titlespacing*{\subsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
% \titlespacing*{\paragraph}   {0pt}{3.25ex plus 1ex minus .2ex}{1em}
% \titlespacing*{\subparagraph} {\parindent}{3.25ex plus 1ex minus .2ex}{1em}

\titlespacing*{\section}                  {0pt}{12pt plus 4pt minus 2pt}{12pt plus 2pt minus 2pt}
\titlespacing*{\subsection}               {0pt}{12pt plus 4pt minus 2pt}{12pt plus 2pt minus 2pt}
\titlespacing*{\subsubsection}            {0pt}{12pt plus 4pt minus 2pt}{12pt plus 2pt minus 2pt}
\titlespacing*{\paragraph}                {0pt}{3.25ex plus 1ex minus .2ex}{1em}
\titlespacing*{\subparagraph}{\parindent} {3.25ex plus 1ex minus .2ex}{1em}





% --------------------------------------------------------------------------------------------------
% OUTROS
% --------------------------------------------------------------------------------------------------

% Remover Espaçamento de figuras, quadros e tabelas agrupadas por capítulo
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}



%==================== Fim da customização da página inicial =====================

\setcounter{tocdepth}{2}% estabelece a "profundidade dos bookmarks".


%==================== Configurando formatação dos códigos-fontes ================
\usepackage{listings}
\usepackage{color}
%\usepackage{courier}

% Altera o nome padrão do rótulo usado no comando \autoref{}
\renewcommand{\lstlistingname}{Quadro}

% Altera o rótulo a ser usando no elemento pré-textual "Lista de código"
\renewcommand{\lstlistlistingname}{Lista de Quadros}

% Configura a "Lista de Códigos" conforme as regras da ABNT (para abnTeX2)
\begingroup\makeatletter
\let\newcounter\@gobble\let\setcounter\@gobbletwo
  \globaldefs\@ne \let\c@loldepth\@ne
%  \newlistof{listings}{lol}{\lstlistlistingname}
%  \newlistentry{lstlisting}{lol}{0}
\endgroup

%\renewcommand{\cftlstlistingaftersnum}{\hfill--\hfill}

%\let\oldlstlistoflistings\lstlistoflistings
%\renewcommand{\lstlistoflistings}{%
%  \begingroup%
%  \let\oldnumberline\numberline%
%  \renewcommand{\numberline}{\lstlistingname\space\oldnumberline}%
%  \oldlstlistoflistings%
%  \endgroup
%}


%\usepackage{titletoc}

%\contentsuse{lstlisting}{lol}
%\titlecontents{lstlisting}[2em]
%{\addvspace{0.75pc}}
%{{\thecontentslabel} }
%{}
%{\titlerule*[0.75em]{$\cdot$}\contentspage}
%[]

%\titlecontents{listing}[0pt]{\vspace{.1\baselineskip}\bfseries}
%{\thecontentslabel\hspace{2.8mm}}{}
%{\hspace{.5em}\titlerule*[5pt]{$\cdot$}\contentspage}


%\usepackage{listings,chngcntr,tocloft}

%\AtBeginDocument{%
%    \counterwithin*{lstlisting}{section}
%    \counterwithin*{lstlisting}{subsection}
%    \counterwithin*{lstlisting}{subsubsection}
%    \renewcommand{\thelstlisting}{%
%        \ifnum\value{subsection}=0
%        \thesection.\arabic{lstlisting}%
%        \else
%        \ifnum\value{subsubsection}=0
%        \thesubsection.\arabic{lstlisting}%
%        \else
%        \thesubsubsection.\arabic{lstlisting}%
%        \fi
%        \fi
%    }%
%}
%\addtolength{\cftfignumwidth}{1em}
%\makeatletter
%\let\l@lstlisting\l@figure
%\makeatother

%\addcontentsline{toc}{section}{\protect\numberline{}{Listings}}


% Cria uma nova customização para a linguagem C++
\lstset{
    alsoother={0123456789_},
    backgroundcolor=\color{white},
    basicstyle=\ttfamily,columns=fullflexible,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    escapeinside={\%*}{*)},
    extendedchars=true,
    frame=shadowbox,
    inputencoding=utf8,
    keepspaces=true,
    numberbychapter=false,
    numbers=left,
%    numbersep=10pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framextopmargin=5pt,
    framexbottommargin=5pt,
    framexleftmargin=5pt,
    framexrightmargin=5pt,
    language=C++,
    literate={á}
    {
        {\'a}}1 {ã}{{\~a}}1 {é}{{\'e}}1 {è}{{\`{e}}}1 {ê}{{\^{e}}}1 {ë}{{\¨{e}}}1 {É}{{\'{E}}}1 {Ê}{{\^{E}}}1 {û}{{\^{u}}}1 {ú}{{\'{u}}}1 {â}{{\^{a}}}1 {à}{{\`{a}}}1 {á}{{\'{a}}}1 {ã}{{\~{a}}}1 {Á}{{\'{A}}}1 {Â}{{\^{A}}}1 {Ã}{{\~{A}}}1 {ç}{{\c{c}}}1 {Ç}{{\c{C}}}1 {õ}{{\~{o}}}1 {ó}{{\'{o}}}1 {ô}{{\^{o}}}1 {Õ}{{\~{O}}}1 {Ó}{{\'{O}}}1 {Ô}{{\^{O}}}1 {î}{{\^{i}}}1 {Î}{{\^{I}}}1 {í}{{\'{i}}}1 {Í}{{\~{Í}}}1
}

%
%==================== Fim da configuração dos códigos-fontes ====================
