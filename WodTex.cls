\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WoDTeX}[2018/07/06 World of Darkness LaTeX]
\LoadClass[a4paper,twocolumns,oneside]{book}
\PassOptionsToPackage{table}{xcolor}
\usepackage{xcolor}
\usepackage{tikz}
%\definecolor{coverGold}{RGB}{235,186,118}
\definecolor{coverFontTitleColor}{RGB}{0, 0, 0}
%451D1D - 692929

\newcommand{\FilledDot}{$\CIRCLE$}
\newcommand{\EmptyDot}{\Circle}
\rowcolors{2}{gray!15}{white}

\newcommand{\head}[1]{%
	\textcolor{white}{\textbf{#1}}}

\newcommand{\firstColumn}[1]{%
	\textcolor{white}{\textbf{#1}}}

\renewcommand{\arraystretch}{1.5}

\DeclareOption{sand}{
	\providecommand{\Theme}{sand}
}
\DeclareOption{marble}{
	\providecommand{\Theme}{marble}
}
\DeclareOption{portuguese}{\PassOptionsToClass{\CurrentOption}{artigo}}
\DeclareOption{english}{\PassOptionsToClass{\CurrentOption}{article}}
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
}%end of Vampire Specifics

\newcommand{\chapterTocFontSize}{24pt}
\newcommand{\chapterChapFontSize}{18pt}
\newcommand{\chapterSecFontSize}{14pt}
\newcommand{\chapterSubSecFontSize}{12pt}
\newcommand{\chapterSubSubSecFontSize}{10pt}

\ProcessOptions\relax
\ExecuteOptions{english,LQ,Vampire}%setting Default
\usepackage{babel}
\usepackage{wodGlyphs}
\usepackage{eso-pic}
\usepackage[a4paper,top=\genreGeometryTop, bottom=\genreGeometryBottom, outer=\genreGeometryOuter, inner=\genreGeometryInner]{geometry}
\usepackage{hyperref}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{mwe,tikz}
\usetikzlibrary{calc}
\usepackage{fontspec}
\usepackage{sectsty}
\usepackage[outline]{contour}% http://ctan.org/pkg/contour
\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\usepackage{textcomp}
\usepackage{blindtext} %only needed for testing
\usepackage{background}
\usepackage{intcalc}
\usepackage{calc}
\usepackage{fmtcount}
\usepackage[explicit]{titlesec}
%\usepackage{enumerate}
\usepackage{enumitem}
\usepackage[percent]{overpic}
\usepackage{relsize}
\usepackage[most]{tcolorbox}
\usepackage{shapepar}
\usepackage{microtype}
\usepackage{wasysym}
\usepackage{xstring}
\usepackage{tocloft}

\backgroundsetup{
	scale=1,
	color=black,
	opacity=1,
	angle=0,
	contents={}
}

\tocloftpagestyle{fancy}
\usetikzlibrary{calc,fit,intersections}
\usetikzlibrary{fadings,shadings,decorations.text}
\usetikzlibrary{patterns}

\addto\captionsenglish{% Replace "english" with the language you use
	\renewcommand{\contentsname}%
	{Content}%
}

\addto\captionsportuguese{% Replace "english" with the language you use
	\renewcommand{\contentsname}%
	{Conteúdo}%
}

\providecommand{\WoDTableOfContents}{
	\afterpage{%
		\begin{tikzpicture}[overlay]
			\node[anchor=center] at (\genreCreditTOCsPos){
				\includegraphics[width=\paperwidth,height=\paperheight]{art/page/Themes/\Theme/page\isLQ}
			};
		\end{tikzpicture}		
		%\newgeometry{top=\genreTOCSpacing}
		% material for this page
		\pagestyle{plain}
		%\ClearShipoutPictureBG
		%\AddToShipoutPictureBG*{%\AtPageLowerLeft{\includegraphics[width=\paperwidth,height=\paperheight]{art/page/Themes/\Theme/page}}}
		
		%\AddToShipoutPictureBG{\includegraphics[width=\paperwidth,height=\paperheight]{art/page/Themes/\Theme/page}}
		{\hypersetup{hidelinks} % Remover a borda fina vermelha dos links
			\tableofcontents
		}
		
		\clearpage
		\ClearShipoutPictureBG
		
		\clearpage
		\restoregeometry
	}
	\pagestyle{fancy}
}

\providecommand{\FrontCover}[2]{
	\thispagestyle{plain}
	\begin{tikzpicture}[overlay]
		\node [anchor=center] at (.38\paperwidth,-.422\paperheight) {
			\includegraphics[width=1.05\paperwidth,height=1.1\paperheight]{art/backgrounds/Themes/\Theme/bg\isLQ}
		};
		\node [anchor=center] at (.47\textwidth,-.422\paperheight) {#2};
		\node [text=\genreFrontTextColor,text width=\textwidth,align=center,anchor=north] at (.47\textwidth,0)
		{
			\fontsize{90pt}{90pt}\fontspec{\genreFont}{#1}
		};
		%
		\node [anchor=center] at (.45\textwidth,-.02\paperheight)
		{
			\fontsize{100pt}{12pt}\fontspec{\coverTitleFont}
			\iflanguage{english}{\color{coverFontTitleColor}\textbf{The Two Cities}}{}
			\iflanguage{portuguese}{\color{coverFontTitleColor}\textbf{As duas cidades}}{}\\
		};				
		%
		\node at (.37\paperwidth,-.84\paperheight) {\includegraphics[width=.4\textwidth]{art/logos/SVWoDLogo}};
	\end{tikzpicture}
}

\providecommand{\Letter}[1]{
	\thispagestyle{plain}
	\begin{tikzpicture}[overlay]
		\node[anchor=center] at (\genreCreditsPos){
			\includegraphics[width=1.0\paperwidth,height=1.0\paperheight]{art/backgrounds/letter}
		};
	\end{tikzpicture}
}

\providecommand{\CreditsPage}[3]{
	\thispagestyle{plain}
	\begin{tikzpicture}[overlay]
		\node[anchor=center] at (\genreCreditTOCsPos){
			\includegraphics[width=\paperwidth,height=\paperheight]{art/page/Themes/\Theme/page\isLQ}
		};
		\node at (2cm,-.73\paperheight) {
			\includegraphics[width=.25\textwidth]{art/logos/WhiteWolfLogo}}
		;
		\node at (.47\textwidth,-.82\paperheight) {
			\includegraphics[width=.95\textwidth,angle=180]{art/sidebar/\genrePath/Sidebar\isLQ}
		};
		\node at (.47\textwidth,-.65\paperheight) {
			\includegraphics[width=.95\textwidth]{art/sidebar/\genrePath/Sidebar\isLQ}
		};
		\node [anchor=north west, text=black] at (-.6cm,.15cm) 
		{
			\fontsize{30pt}{30pt}\fontspec{\theFontSection}
			\iflanguage{english}{\textbf{Credits}}{}
			\iflanguage{portuguese}{\textbf{Créditos}}{}
		};
		\node [anchor=north west] at (.48\textwidth,.3cm) {
			\fontsize{30pt}{30pt}\fontspec{\theFontSection}
			\iflanguage{english}{\textbf{Special Thanks}}{}
			\iflanguage{portuguese}{\textbf{Agradecimentos especiais}}{}
		};
		\node [anchor=north west, text width=.47\textwidth,align=justify] at (-0.6cm,-1.1cm) 
		{%
			\iflanguage{english}{\textbf{Created by:}}{}
			\iflanguage{portuguese}{\textbf{Criado por:}}{}\\#1\\
		};
		\node [anchor=north west, text width=.47\textwidth,align=justify] at (.48\textwidth,-1.1cm) {
			#2			
		};
		
		\node [anchor=north west, text=black] at (-.6cm,-.3\paperheight)
		{
			\fontsize{30pt}{30pt}\fontspec{\theFontSection}
			\iflanguage{english}{\textbf{Dedicated to}}{}
			\iflanguage{portuguese}{\textbf{Dedicado a}}{}\\
		};
		\node [anchor=north west, text width=.47\textwidth,align=justify] at (-.6cm,-.34\paperheight)
		{%
			#3
		};
		
		\node [text width=.7\textwidth,align=justify] at (.62\textwidth,-.735\paperheight){\textcircled{c}  2017  White  Wolf  Entertainment  AB.  All  rights  reserved.  Vampire:  The Masquerade\textcircled{R}, World of Darkness\textcircled{R}, Storytelling System$^{TM}$, and Storytellers Vault$^{TM}$ are trademarks and/or registered trademarks of White Wolf Entertainment AB. All rights reserved.\\ For additional information on White Wolf and the World of Darkness, please, visit: www.white-wolf.com, www.worldofdarkness.com and www.storytellersvault.com.\\ Created with \WoDTeX};
	\end{tikzpicture}
}

\providecommand{\WoDTeX}{
	\smash{
		\raisebox{-0.26\height}{
			\includegraphics[width=1.2cm]{art/logos/WoDTeXLogo}
		}
	}
}

\providecommand{\WoDFrame}[1]{
	\includegraphics[width=.49\textwidth]{
		art/sidebar/\genrePath/SidebarSmall\isLQ
	}\\
	%Content between he pictures
	#1\\
	%End of content
	\includegraphics[width=.49\textwidth,angle=180]{
		art/sidebar/\genrePath/SidebarSmall\isLQ
	}\\
}

\providecommand{\BigWoDFrame}[1]{
	{
		\center\includegraphics[width=.95\textwidth]{
			art/sidebar/\genrePath/Sidebar\isLQ
		}
	}\\
	#1\\
	{
		\center\includegraphics[width=.95\textwidth,angle=180]{
			art/sidebar/\genrePath/Sidebar\isLQ
		}
	}\\
}

\providecommand{\BigWoDSeperator}[1]{
	{\center
		\begin{tikzpicture}
			\node {\includegraphics[width=.95\textwidth]{art/sidebar/\genrePath/SidebarBroken\isLQ}};
			\node [anchor=center, align=center]at (0,-.5mm){
				\textbf{
					\fontspec{
						\theFont
					}
					\fontsize{23}{20}\selectfont #1}};
		\end{tikzpicture}
	}
}

\providecommand{\textGenreAndSize}[2]{
	{\fontspec{\theFont}\fontsize{#2}{#2}\selectfont #1}
}

\newcommand{\chapTitle}[2]{%
	\stepcounter{chapter}
	\newpage % Inserir nova página para garantir que a imagem de fundo seja aplicada apenas à primeira página do capítulo
	\noindent%
	\begin{tikzpicture}[overlay]
		% Adicionar imagem de fundo para a primeira página do capítulo
		\node[anchor=center] at (\genreChapTitlePos){%
			\includegraphics[width=\paperwidth,height=\paperheight]{art/chapter/Themes/\Theme/chapter\isLQ}%
		};
		% Adicionar título e subtítulo
		\node [align=center,text width=.8\textwidth, opacity=0.9] at (.5\textwidth,0) {#1\\#2};
	\end{tikzpicture}
	% Adicionar imagem de fundo para as outras páginas do capítulo
	\AddToShipoutPictureBG{%
		\AtPageLowerLeft{%
			\includegraphics[width=\paperwidth,height=\paperheight]{art/page/Themes/\Theme/page\isLQ}%
		}%
	}
	\vspace*{\genreChapterSpacing}
	\addcontentsline{toc}{chapter}{#1\ #2}
}

\newcommand{\inTextPicture}[3][R]{
	\begin{wrapfigure}{#1}{#2}
		\centering
		\includegraphics[width=#2]{#3}
	\end{wrapfigure}
}

\newcommand{\chapterCiting}[2]{
	\begin{tikzpicture}[overlay]
		\node [align=center,text width=.7\textwidth] at (.492\textwidth,1.5cm) {"\textit{#1}"\\-\textbf{#2}};
	\end{tikzpicture}
}

\setmainfont{Goudy Old Style}

\newcommand{\theFont             }{\genreFont}
\newcommand{\theFontSection      }{\genreFont}
\newcommand{\theFontSubSection   }{\genreFont}
\newcommand{\theFontSubSubSection}{\genreFont}

\newcommand{\coverTitleFont}{\titleFont}

% settings for table of contents
\cftpagenumbersoff{chapter}
\renewcommand{\cfttoctitlefont}{\hfill\color{\genreTOCTitleColor}\fontsize{\chapterTocFontSize}{\chapterTocFontSize}\fontspec{\theFont}\bfseries} % Altere 24pt para o tamanho desejado
\renewcommand{\cftchapfont}{\fontspec{\theFont}\color{\genreTOCBodyColor}\fontsize{\chapterChapFontSize}{\chapterChapFontSize}\bfseries} % Altere 18pt para o tamanho desejado
\renewcommand{\cftsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSecFontSize}{\chapterSecFontSize}\fontspec{\theFontSection}\bfseries} % Altere 14pt para o tamanho desejado
\renewcommand{\cftsubsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSecFontSize}{\chapterSubSecFontSize}\fontspec{\theFontSection}\bfseries} % Altere 12pt para o tamanho desejado
\renewcommand{\cftsubsubsecfont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSubSecFontSize}{\chapterSubSubSecFontSize}\fontspec{\theFontSection}\bfseries} % Altere 10pt para o tamanho desejado

\renewcommand{\cftchappagefont}{\fontspec{\theFont}\color{\genreTOCBodyColor}\fontsize{\chapterChapFontSize}{\chapterChapFontSize}\bfseries}
\renewcommand{\cftsecpagefont}{\color{\genreTOCBodyColor}\fontsize{\chapterSecFontSize}{\chapterSecFontSize}\fontspec{\theFontSection}\bfseries}
\renewcommand{\cftsubsecpagefont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSecFontSize}{\chapterSubSecFontSize}\fontspec{\theFontSection}\bfseries}
\renewcommand{\cftsubsubsecpagefont}{\color{\genreTOCBodyColor}\fontsize{\chapterSubSubSecFontSize}{\chapterSubSubSecFontSize}\fontspec{\theFontSection}\bfseries}
\renewcommand{\cftdot}{}
\renewcommand{\cftchapafterpnum}{\hspace*{7.5em}}
\renewcommand{\cftsecafterpnum}{\hspace*{7.5em}}
\renewcommand{\cftsubsecafterpnum}{\hspace*{7.5em}}
\renewcommand{\cftsubsubsecafterpnum}{\hspace*{7.5em}}
\renewcommand\cftchapindent{2cm}
\renewcommand\cftsecindent{2.5cm}
\renewcommand\cftsubsecindent{3cm}
\renewcommand\cftsubsubsecindent{3.5cm}

\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % Adiciona pontos líderes para os capítulos
\renewcommand{\cftchapafterpnum}{\cftparfillskip} % Adiciona espaço de preenchimento para os capítulos
\cftpagenumberson{chapter} % Habilita a exibição dos números de página para os capítulos no TOC


\renewcommand\cftaftertoctitle{\vspace{\genreTOCSpacingFirstEntry}\hfill\mbox{}}
\setlength{\cftaftertoctitleskip}{-.5cm}

\definecolor{darkred}{HTML}{5D2428}
\definecolor{lightwhite}{HTML}{EBF0EE}

\newcommand{\translatedChapter}{Language not found}
\iflanguage{english}{\renewcommand{\translatedChapter}{Chapter\ }}{}
\iflanguage{portuguese}{\renewcommand{\translatedChapter}{Capítulo\ }}{}

\titleformat{\chapter}%Capítulo
{\fontspec{\theFont}\fontsize{50pt}{50pt}\bfseries\color{lightwhite}}
{}{-.29em}{\chapTitle{#1}}


\titleformat{\section}%Seção
{\color{black}\fontsize{30pt}{30pt}\fontspec{\theFontSection}\bfseries}
%{\thesection}{1em}{\addcontentsline{toc}{section}{#1}\titlerule[1.5pt]#1}
{\thesection}{1em}{#1}
\titleformat{\subsection}%Subseção
{\fontsize{18pt}{18pt}\fontspec{\theFontSubSection}\bfseries}
%{\thesubsection}{1em}{\addcontentsline{toc}{subsection}{#1}#1}
{\thesubsection}{1em}{#1}

\titleformat{\subsubsection}%Subsubseção
{\fontsize{14pt}{14pt}\fontspec{\theFontSubSubSection}\bfseries}
%{\thesubsubsection}{1em}{\addcontentsline{toc}{subsubsection}{#1}#1}
{\thesubsubsection}{1em}{#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Subsubsubseção - 4
% Configurando a numeração do novo nível
\setcounter{secnumdepth}{4}
\newcommand{\thesubsubsubsection}{\thesubsubsection.\arabic{subsubsubsection}}

\titleclass{\subsubsubsection}{straight}[\subsubsection]

% Configurando a formatação do novo nível
\titleformat{\subsubsubsection}
{\fontsize{12pt}{12pt}\fontspec{\theFontSubSubSection}\bfseries}
%{\thesubsubsubsection}{1em}{\addcontentsline{toc}{subsubsubsection}{#1}#1}
{\thesubsubsubsection}{1em}{#1}

% Configurando o espaçamento do novo nível
\titlespacing*{\subsubsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Subsubsubsubseção - 5
% Configurando a numeração do novo nível
\setcounter{secnumdepth}{5}
\newcommand{\thesubsubsubsubsection}{
	\thesubsubsection.\arabic{subsubsubsubsection}
}

\titleclass{\subsubsubsubsection}{straight}[\subsubsubsection]

% Configurando a formatação do novo nível
\titleformat{\subsubsubsubsection}
{\fontsize{11pt}{11pt}\fontspec{\theFontSubSubSection}\bfseries}
%{\thesubsubsubsubsection}{1em}{\addcontentsline{toc}{subsubsubsubsection}{#1}#1}
{\thesubsubsubsubsection}{1em}{#1}

% Configurando o espaçamento do novo nível
\titlespacing*{\subsubsubsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{fancyhdr}
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{empty}% Remove o número de página da primeira página do capítulo
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}

\pagestyle{fancy}
\fancyhf{} % clear all footer fields
\renewcommand{\headrulewidth}{0.0pt} %no rule for header
\renewcommand{\footrulewidth}{0.0pt} %no rule for footer

\fancyfoot[LE,RO]{
	{\fontsize{14}{14}\fontspec{\theFontSubSection} \thepage}
}

\fancyfoot[C]{
	{\fontsize{14}{14}\fontspec{\theFontSubSection} \chaptername{}\ \thechapter}
}

% Define um novo estilo de página para as páginas iniciais do capítulo
\fancypagestyle{chapterstart}{
	\fancyhf{} % Limpa todos os campos de rodapé
	\renewcommand{\headrulewidth}{0pt} % Remove a linha horizontal no cabeçalho
	\renewcommand{\footrulewidth}{0pt} % Remove a linha horizontal no rodapé
}

\pretocmd{\chapter}{\thispagestyle{chapterstart}}{}{}
\endinput
