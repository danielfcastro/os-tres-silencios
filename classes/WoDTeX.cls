\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WoDTeX}[2018/07/06 World of Darkness LaTeX]

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
\RequirePackage{babel}

% ===== Fontes (LuaLaTeX/XeLaTeX) com Path local =====
\ifPDFTeX
  \PackageWarningNoLine{WoDTeX}{This class requires LuaLaTeX or XeLaTeX. Falling back will break fonts.}
\fi
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX,Scale=MatchLowercase}
% Caminho das fontes do projeto
\newcommand{\WoDFontsPath}{fonts/}

% Fonte principal = EB Garamond do repo
\IfFileExists{\WoDFontsPath EBGaramond12-Regular.ttf}{%
  \setmainfont{EBGaramond12-Regular.ttf}[
    Path=\WoDFontsPath ,
    BoldFont = Garamond-Bold.ttf,
    ItalicFont = EBGaramond12-Italic.ttf,
    BoldItalicFont = EBGaramond12-Italic.ttf]
}{%
  % Fallback: TeX Gyre Pagella
  \setmainfont{TeX Gyre Pagella}
}

% Fonte de display (títulos) = Delavan do repo (se existir)
\newcommand{\WoDHasDelavan}{}
\IfFileExists{\WoDFontsPath delavan.ttf}{%
  \newfontfamily\WoDDisplay{delavan.ttf}[Path=\WoDFontsPath]
  \renewcommand{\WoDHasDelavan}{yes}
}{%
  \newcommand{\WoDDisplay}{\relax}
}

% ===== Cores =====
\definecolor{coverFontTitleColor}{RGB}{0,0,0}
\definecolor{darkred}{HTML}{5D2428}
\definecolor{lightwhite}{HTML}{EBF0EE}

% ===== Layout =====
\geometry{top=\genreGeometryTop, bottom=\genreGeometryBottom, inner=\genreGeometryInner, outer=\genreGeometryOuter}
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

% ===== Backgrounds opcionais (só se os arquivos existirem) =====
\newcommand{\chapTitle}[1]{%
  \noindent%
  \begin{tikzpicture}[overlay]
    \edef\BGChapter{art/chapter/Themes/\Theme/chapter\isLQ}
    \IfFileExists{\BGChapter}{%
      \node[anchor=center] at (\genreChapTitlePos){\includegraphics[width=\paperwidth,height=\paperheight]{\BGChapter}};
    }{}
  \end{tikzpicture}
  \edef\BGPage{art/page/Themes/\Theme/page\isLQ}
  \IfFileExists{\BGPage}{%
    \AddToShipoutPictureBG{%
      \AtPageLowerLeft{\includegraphics[width=\paperwidth,height=\paperheight]{\BGPage}}}
  }{}
  \vspace*{\genreChapterSpacing}
  \addcontentsline{toc}{chapter}{#1}
}

% ===== TOC =====
\newcommand{\chapterTocFontSize}{24pt}
\newcommand{\chapterChapFontSize}{18pt}
\newcommand{\chapterSecFontSize}{14pt}
\newcommand{\chapterSubSecFontSize}{12pt}
\newcommand{\chapterSubSubSecFontSize}{10pt}

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

% ===== Idioma =====
\addto\captionsenglish{\renewcommand{\contentsname}{Content}}
\addto\captionsportuguese{\renewcommand{\contentsname}{Conteúdo}}

% ===== Formatação dos títulos (usa Delavan se disponível) =====
\titleformat{\chapter}{\bfseries\color{lightwhite}\ifx\WoDHasDelavan\empty\else\WoDDisplay\fi}{}{-.29em}{\chapTitle{#1}}
\titleformat{\section}{\bfseries\color{black}\ifx\WoDHasDelavan\empty\else\WoDDisplay\fi}{\thesection}{1em}{#1}
\titleformat{\subsection}{\bfseries\ifx\WoDHasDelavan\empty\else\WoDDisplay\fi}{\thesubsection}{1em}{#1}
\titleformat{\subsubsection}{\bfseries\ifx\WoDHasDelavan\empty\else\WoDDisplay\fi}{\thesubsubsection}{1em}{#1}

\setcounter{secnumdepth}{4}

\endinput
