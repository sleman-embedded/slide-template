%%=====================================================================
%%  slemanslides.cls
%%  16:9, white background, brand blue. Compile with pdfLaTeX.
%%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slemanslides}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[aspectratio=169,11pt,t]{beamer}

%% ------- Base packages -----------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{listings}
\RequirePackage{etoolbox}
\RequirePackage{amssymb}
\RequirePackage{tikz}
\RequirePackage[listings,skins,xparse]{tcolorbox}

\graphicspath{{img/}{./}}

%% ------- Fonts -------------------------------------------------------
%% Text: Fira Sans > Lato > Helvetica. Code: Fira Mono > Inconsolata.
\IfFileExists{FiraSans.sty}{%
  \RequirePackage[sfdefault,book,lining]{FiraSans}%
}{\IfFileExists{lato.sty}{%
  \RequirePackage[defaultsans]{lato}%
}{%
  \RequirePackage[scaled=0.96]{helvet}%
}}
\IfFileExists{FiraMono.sty}{%
  \RequirePackage[scaled=0.88,lining]{FiraMono}%
}{\IfFileExists{inconsolata.sty}{%
  \RequirePackage[scaled=0.95]{inconsolata}%
}{}}
\renewcommand{\familydefault}{\sfdefault}

%% ------- Colors ------------------------------------------------------

%% Taken from the logo: blue #004AAD and bolt shadow #99ACFF.
\definecolor{brandblue}{RGB}{0,74,173}
\definecolor{brandlight}{RGB}{153,172,255}
\definecolor{brandpale}{RGB}{238,242,252}
\definecolor{ink}{RGB}{26,31,43}
\definecolor{muted}{RGB}{110,116,130}
\definecolor{orange}{RGB}{240,128,32}
\definecolor{red}{RGB}{204,51,51}
\definecolor{green}{RGB}{30,140,80}

%% Code (dark theme)
\definecolor{codebg}{RGB}{30,34,44}
\definecolor{codebar}{RGB}{44,50,64}
\definecolor{codefg}{RGB}{220,224,232}
\definecolor{codekw}{RGB}{122,162,255}
\definecolor{codetype}{RGB}{86,200,216}
\definecolor{codestr}{RGB}{240,170,90}
\definecolor{codecomment}{RGB}{120,128,145}
\definecolor{codepre}{RGB}{200,140,240}

%% ------- Lesson info -------------------------------------------------
\newcommand{\@course}{}
\newcommand{\@lesson}{}
\newcommand{\course}[1]{\renewcommand{\@course}{#1}}
\newcommand{\lesson}[1]{\renewcommand{\@lesson}{#1}}

%% ------- General look ------------------------------------------------

\beamertemplatenavigationsymbolsempty
\setbeamercolor{normal text}{fg=ink}
\setbeamercolor{structure}{fg=brandblue}
\usefonttheme{professionalfonts}
\setbeamersize{text margin left=12mm, text margin right=12mm}

%% Small bolt in the top right corner of content slides.
\setbeamertemplate{background}{%
  \begin{tikzpicture}
    \useasboundingbox (0,0) rectangle (\paperwidth,\paperheight);
    \node[anchor=north east,inner sep=0pt]
      at (\paperwidth-6mm,\paperheight-5mm)
      {\includegraphics[height=9mm]{bolt}};
  \end{tikzpicture}%
}




%% ------- Cover -------------------------------------------------------
%% Uses \title, \course and \lesson from the preamble.
\newcommand{\cover}{%
  {\setbeamertemplate{background}{%
     \begin{tikzpicture}
       \useasboundingbox (0,0) rectangle (\paperwidth,\paperheight);
       \node[anchor=east,inner sep=0pt,opacity=0.12]
         at (\paperwidth+18mm,0.45\paperheight)
         {\includegraphics[height=1.25\paperheight]{bolt}};
       \fill[brandblue] (0,0) rectangle (\paperwidth,3mm);
     \end{tikzpicture}}%
   \begin{frame}[plain]
     \vskip4mm
     \hskip2mm\includegraphics[height=13mm]{logo}
     \vfill
     \hskip4mm\begin{minipage}{0.72\paperwidth}
       \ifdefempty{\@lesson}{}{%
         {\color{brandblue}\bfseries\normalsize\MakeUppercase{\@lesson}}\par
         \vskip3mm}%
       {\color{ink}\bfseries\fontsize{32}{36}\selectfont\inserttitle\par}
     \end{minipage}
     \vfill
     \hskip4mm{\color{muted}\small\@course}
     \vskip8mm
   \end{frame}}%
}