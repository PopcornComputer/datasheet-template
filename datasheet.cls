%% LaTeX document class for formatting Solder Party datasheets.
%%
%% Copyright 2021 arturo182
%% Copyright 2020 Petteri Aimonen
%%
%% fork: https://github.com/solderparty/datasheet-template/
%% original: https://github.com/PetteriAimonen/latex-datasheet-template/
%%
%% --------------------------------------------------------------------------
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% This Current Maintainer of this work is arturo182.
%% 
%% This work consists of the file datasheet.cls and the example
%% document example.tex.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{datasheet}[2021/04/17 LaTeX document class for Solder Party datasheets]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Useful symbol and color definitions
\RequirePackage{gensymb}
\RequirePackage{xcolor}
\RequirePackage{tikz}

% These packages allow full-width tables and combining cells in tables.
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{threeparttable}
\RequirePackage{lmodern}

% Nice and modern Font
\RequirePackage{fontspec}
\setmainfont{Open Sans}

\RequirePackage{fancyhdr}

% Align figure and table captions to left.
\RequirePackage[font=bf, skip=5pt, justification=raggedright, format=hang, singlelinecheck=off]{caption}

\definecolor{silver}{HTML}{FAF8FD}
\definecolor{border}{HTML}{DEE2E6}
\definecolor{spviolet}{HTML}{6124c2}
\definecolor{urlcolor}{HTML}{8953df}

% Format hyperlinks as blue and set PDF title based on \title{} in the document.
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{
	pdftex,
	breaklinks=true,
	colorlinks=true,
	linkcolor=.,
	urlcolor=urlcolor
}

% Configure page margins
\RequirePackage[includehead,includefoot]{geometry}
\geometry{top=2cm, bottom=2cm, left=2cm,  right=2cm}

% Datasheet version
\gdef\@version{}
\newcommand{\version}[1]{\gdef\@version{v#1}}

% Our website
\gdef\@website{}
\newcommand{\website}[1]{\gdef\@website{#1}}

% Title page is defined here
\renewcommand{\maketitle}{%
	\begin{tikzpicture}[remember picture,overlay]
		\node (titlebg) [
			shape=rectangle, 
			draw=border, 
			fill=silver, 
			line width=0.5mm, 
			minimum height=40mm, 
			minimum width=200mm, 
			anchor=east, 
			xshift=2mm, 
			yshift=6cm
		] at (current page.east) {};

		\node [
			anchor=east,
			xshift=-4.5mm
		] at (titlebg.east) {
			\begin{tabular}{r}
				\fontsize{50pt}{50pt}\selectfont\textbf{\@title} \\
				\fontsize{40pt}{40pt}\selectfont\color{gray}{Datasheet}
			\end{tabular}
		};

		\node (sidebar) [
			anchor=north west, 
			shape=rectangle,
			fill=spviolet, 
			minimum height=290mm, 
			minimum width=40mm
		] at (current page.north west) {};

		\node [
			anchor=south east, 
			font=\fontsize{16pt}{16pt}\selectfont, 
			xshift=-3mm, 
			yshift=3mm
		] at (current page.south east) {
			\begin{tabular}{r}
				\textbf{Solder Party AB}\\
				\href{www.solder.party}{\color{black}{www.solder.party}}
			\end{tabular}
		};

		\node [
			anchor=south west, 
			font=\fontsize{16pt}{16pt}\selectfont, 
			yshift=15.5mm, 
			xshift=3mm
		] at (sidebar.south east) {
			Version 1.0
		};
	\end{tikzpicture}
}

% Color the header and footer rules
\futurelet\TMPfootrule\def\footrule{{\color{spviolet}\TMPfootrule}}
\futurelet\TMPheadrule\def\headrule{{\color{spviolet}\TMPheadrule}}

% Make sure \sectionmark updates \markright
\renewcommand{\sectionmark}[1]{\markright{\thesection~- ~#1}}

% Normal pages have both header and footer
\fancypagestyle{normalpage}{
	\renewcommand{\headrulewidth}{5pt}
	\renewcommand{\footrulewidth}{5pt}

	\fancyhead[L]{\color{spviolet}{\@author\ \@title\ \@version}}
	\fancyhead[C]{}
	\fancyhead[R]{}

	\fancyfoot[L]{\color{spviolet}{\nouppercase{\rightmark}}}
	\fancyfoot[C]{}
	\fancyfoot[R]{\color{spviolet}{\thepage}}
}

% Spacing between paragraphs
\setlength{\parskip}{2ex plus 0.5ex minus 0.2ex}
\setlength{\parindent}{0pt}

% Spacing for tables.
% Other alternative is to use booktabs package, but I think normal LaTeX tables
% are more fitting in the usual data sheet style.
\renewcommand{\arraystretch}{1.5}
\newcommand{\thickhline}{\noalign {\ifnum 0=`}\fi \hrule height 1pt \futurelet \reserved@a \@xhline}
