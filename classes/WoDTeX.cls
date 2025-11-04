\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WoDTeX}[2018/07/06 World of Darkness LaTeX]

% Baseia em book (a4, uma coluna; sua versão tinha "twocolumns" — o nome certo é "twocolumn")
\LoadClass[a4paper,oneside]{book}

% ===== Opções =====
\DeclareOption{sand}{\providecommand{\Theme}{sand}}
\DeclareOption{marble}{\providecommand{\Theme}{marble}}
\DeclareOption{portuguese}{\PassOptionsToPackage{\CurrentOption}{babel}}
\DeclareOption{english}{\PassOptionsToPackage{\CurrentOption}{babel}}
\DeclareOption{LQ}{\providecommand{\isLQ}{_LQ}}
\DeclareOption{HQ}{\providecommand{\isLQ}{}}
\DeclareOption{Vampire}{
  \providecommand{\genrePath}{Vampire}
  \providecommand{\genreFont}{Delavan}
  \providecommand{\titleFont}{DeRoos}
  \providecommand{\genreFrontTextColor}{black}
  \providecommand{\genreGeometryTop}{2.5cm}
  \providecommand{\genreGeometryBottom}{3.5cm}
  \providecommand{\genreGeometryInner}{2.5cm}
  \providecommand{\genreGeometryOuter}{2.5cm}
  \providecommand{\genreChapterSpacing}{6cm}
  \providecommand{\genreTOCSpacing}{2cm}
  \providecommand{\genreTOCSpacingFirstEntry}{1.5cm}
  \providecommand{\genreChapTitlePos}{.38\paperwidth,-.31\paperheight}
  \providecommand{\genreCreditTOCsPos}{.356\paperwidth,-.404\paperheight}
  \providecommand{\genreTOCTitleColor}{black}
  \providecommand{\genreTOCBodyColor}{black}
}
\ProcessOptions\relax
\ExecuteOptions{english,LQ,Vampire}

% ===== Pacotes essenciais =====
\RequirePackage{iftex}
\RequirePackage{ifthen}
\RequirePackage{ifmtarg}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{wrapfig}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{tikz}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage[most]{tcolorbox}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{tocloft}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}

% Babel (idioma passado por opção)
\RequirePackage{babel}

% ===== Fonte com fallback =====
\ifPDFTeX
  % Sem fontspec no pdfTeX: usa Latin Modern
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{lmodern}
\else
  % XeLaTeX/LuaLaTeX
  \RequirePackage{fontspec}
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
  \newcommand{\TrySetMainFont}[1]{%
    \IfFontExistsTF{#1}{\setmainfont{#1}}{\relax}}
  % Tenta Goudy; se não houver, usa TeX Gyre Pagella
  \TrySetMainFont{Goudy Old Style}
  \IfFontExistsTF{Goudy Old Style}{}{%
    \setmainfont{TeX Gyre Pagella}}
\fi

% wodGlyphs opcional
\IfFileExists{wodGlyphs.sty}{\RequirePackage{wodGlyphs}}{}

% ===== Cores e pequenos utilitários =====
\definecolor{coverFontTitleColor}{RGB}{0,0,0}
\definecolor{darkred}{HTML}{5D2428}
\definecolor{lightwhite}{HTML}{EBF0EE}

\newcommand{\FilledDot}{$\CIRCLE$}
\newcommand{\EmptyDot}{\Circle}

% ===== Margens =====
\geometry{top=\genreGeometryTop, bottom=\genreGeometryBottom, inner=\genreGeometryInner, outer=\genreGeometryOuter}

% ===== Hiperlinks =====
\hypersetup{hidelinks}

% ===== tcolorbox =====
\tcbuselibrary{skins,breakable}
\tcbset{enhanced,sharp corners,boxrule=0.4pt,colback=white}

% ===== Cabeçalho/Rodapé =====
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[LE,RO]{\thepage}
\fancyfoot[C]{\chaptername\ \thechapter}
\fancypagestyle{chapterstart}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}}
\pretocmd{\chapter}{\thispagestyle{chapterstart}}{}{}

% ===== Títulos (chapters/sections) =====
\IfFileExists{sectsty.sty}{\RequirePackage{sectsty}}{}
\newcommand{\theFont}{\genreFont}
\newcommand{\theFontSection}{\genreFont}
\newcommand{\theFontSubSection}{\genreFont}
\newcommand{\theFontSubSubSection}{\genreFont}
\newcommand{\coverTitleFont}{\titleFont}

% Títulos
\newcommand{\chapTitle}[1]{%
  \noindent%
  \begin{tikzpicture}[overlay]
    % fundo do capítulo (opcional: só inclui se o arquivo existir)
    \edef\BGChapter{art/chapter/Themes/\Theme/chapter\isLQ}
    \IfFileExists{\BGChapter}{%
      \node[anchor=center] at (\genreChapTitlePos){\includegraphics[width=\paperwidth,height=\paperheight]{\BGChapter}};
    }{}
  \end{tikzpicture}
  % plano de fundo das páginas seguintes (opcional)
  \edef\BGPage{art/page/Themes/\Theme/page\isLQ}
  \IfFileExists{\BGPage}{%
    \AddToShipoutPictureBG{%
      \AtPageLowerLeft{\includegraphics[width=\paperwidth,height=\paperheight]{\BGPage}}}
  }{}
  \vspace*{\genreChapterSpacing}
  \addcontentsline{toc}{chapter}{#1}
}

\newcommand{\chapterTocFontSize}{24pt}
\newcommand{\chapterChapFontSize}{18pt}
\newcommand{\chapterSecFontSize}{14pt}
\newcommand{\chapterSubSecFontSize}{12pt}
\newcommand{\chapterSubSubSecFontSize}{10pt}

% TOC estilizada
\cftpagenumbersoff{chapter}
\renewcommand{\cfttoctitlefont}{\hfill\color{\genreTOCTitleColor}\fontsize{\chapterTocFontSize}{\chapterTocFontSize}\bfseries}
\renewcommand{\cftchapfont}{\color{\genreTOCBodyColor}\fontsize{\chapterChapFontSize}{\chapterChapFontSize}\bfseries}
\renewcommand{\cftsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSecFontSize}{\chapterSecFontSize}\bfseries}
\renewcommand{\cftsubsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSecFontSize}{\chapterSubSecFontSize}\bfseries}
\renewcommand{\cftsubsubsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSubSecFontSize}{\chapterSubSubSecFontSize}\bfseries}
\renewcommand{\cftdot}{}
\cftpagenumberson{chapter}
\renewcommand\cftaftertoctitle{\vspace{\genreTOCSpacingFirstEntry}\hfill\mbox{}}
\setlength{\cftaftertoctitleskip}{-.5cm}

% Idioma
\newcommand{\translatedChapter}{Language not found}
\addto\captionsenglish{\renewcommand{\contentsname}{Content}}
\addto\captionsportuguese{\renewcommand{\contentsname}{Conteúdo}}
\AtBeginDocument{%
  \ifthenelse{\equal{\languagename}{english}}{\renewcommand{\translatedChapter}{Chapter\ }}{}%
  \ifthenelse{\equal{\languagename}{portuguese}}{\renewcommand{\translatedChapter}{Capítulo\ }}{}%
}

% Formatos (usa \chapTitle acima)
\titleformat{\chapter}{\bfseries\color{lightwhite}}{}{-.29em}{\chapTitle{#1}}
\titleformat{\section}{\color{black}\bfseries}{\thesection}{1em}{#1}
\titleformat{\subsection}{\bfseries}{\thesubsection}{1em}{#1}
\titleformat{\subsubsection}{\bfseries}{\thesubsubsection}{1em}{#1}

% Suporte até subsubsub(sub)sections (se você realmente quiser)
\setcounter{secnumdepth}{4}

\endinput
