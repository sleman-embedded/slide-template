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
\IfFileExists{FiraSans.sty}{
  \RequirePackage[sfdefault,book,lining]{FiraSans}%
}{\IfFileExists{lato.sty}{
  \RequirePackage[defaultsans]{lato}%
}{%
  \RequirePackage[scaled=0.96]{helvet}%
}}
\IfFileExists{FiraMono.sty}{
  \RequirePackage[scaled=0.88,lining]{FiraMono}%
}{\IfFileExists{inconsolata.sty}{
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
\setbeamertemplate{background}{
  \begin{tikzpicture}
    \useasboundingbox (0,0) rectangle (\paperwidth,\paperheight);
    \node[anchor=north east,inner sep=0pt]
      at (\paperwidth-6mm,\paperheight-5mm)
      {\includegraphics[height=9mm]{bolt}};
  \end{tikzpicture}
}

%% ------- Slide title -------------------------------------------------
\setbeamertemplate{frametitle}{
  \vskip6mm
  {\color{ink}\bfseries\Large\insertframetitle}\par
  \vskip1.5mm
  {\color{brandblue}\rule{14mm}{2pt}}%
  \vskip-1mm
}

%% ------- Footer: course on the left, slide number on the right -------
\setbeamertemplate{footline}{
  \hbox to \paperwidth{
    \hskip12mm{\color{muted}\scriptsize\@course}\hfill
    {\color{muted}\scriptsize\insertframenumber}\hskip12mm}%
  \vskip5mm%
}

%% ------- Lists -------------------------------------------------------
\setbeamertemplate{itemize item}{\color{brandblue}\small$\blacktriangleright$}
\setbeamertemplate{itemize subitem}{\color{brandlight}\textendash}
\setbeamertemplate{itemize subsubitem}{\color{muted}\textbullet}
\setbeamertemplate{enumerate item}{\color{brandblue}\bfseries\insertenumlabel.}
\setbeamertemplate{enumerate subitem}{\color{brandblue}\insertsubenumlabel)}

%% ------- Text highlight ----------------------------------------------
\newcommand{\blue}[1]{\textcolor{brandblue}{#1}}
\newcommand{\orange}[1]{\textcolor{orange}{#1}}
\newcommand{\red}[1]{\textcolor{red}{#1}}
\newcommand{\green}[1]{\textcolor{green}{#1}}
%% \term{...}  keyword in bold blue
\newcommand{\term}[1]{\textcolor{brandblue}{\bfseries #1}}

%% ------- Concept card ------------------------------------------------
%% Blue bar on the left, term on top, definition below.
%%   \concept{Interrupt}{A hardware event that diverts the program flow...}
\newcommand{\concept}[2]{
  \par\medskip
  \noindent\begin{tikzpicture}
    \node[fill=brandpale,inner sep=8pt,text width=\linewidth-16pt-3pt,
          anchor=north west] (c) at (3pt,0)
      {{\color{brandblue}\bfseries\large #1}\par\smallskip
       {\color{ink}#2}};
    \fill[brandblue] (c.north west) ++(-3pt,0) rectangle (c.south west);
  \end{tikzpicture}\par\medskip
}

%% ------- Callouts ----------------------------------------------------
%% Colored label + text, with a side bar in the callout color.
\newcommand{\slemanbox}[3]{
  \par\smallskip
  \noindent\begin{tikzpicture}
    \node[draw=#1!35,fill=#1!6,inner sep=6pt,
          text width=\linewidth-12pt-3pt,anchor=north west] (c) at (3pt,0)
      {{\color{#1}\bfseries\scriptsize #2}\par\vskip2pt
       {\color{ink}\small #3}};
    \fill[#1] (c.north west) ++(-3pt,0) rectangle (c.south west);
  \end{tikzpicture}\par\smallskip
}
\newcommand{\info}[1]{\slemanbox{brandblue}{NOTE}{#1}}
\newcommand{\tip}[1]{\slemanbox{green}{TIP}{#1}}
\newcommand{\warn}[1]{\slemanbox{orange}{WARNING}{#1}}
\newcommand{\danger}[1]{\slemanbox{red}{DANGER}{#1}}

%% ------- Code --------------------------------------------------------
%% Dark theme (looks good on video). Common firmware types are
%% highlighted. Usage:
%%   \begin{code}[title=main.c]          (C by default)
%%   \begin{code}[language=bash,title=terminal]
\lstdefinelanguage{embC}[ANSI]{C}{
  morekeywords=[2]{uint8_t,uint16_t,uint32_t,uint64_t,int8_t,int16_t,
    int32_t,int64_t,size_t,bool,true,false,NULL},
  morekeywords={volatile,inline,static,const,__IO,__I,__O},
  moredelim=*[directive]\#,
  moredirectives={include,define,ifdef,ifndef,endif,if,else,elif,pragma},
}
\lstdefinestyle{sleman}{
  language=embC,
  basicstyle=\ttfamily\small\color{codefg},
  keywordstyle=\color{codekw}\bfseries,
  keywordstyle=[2]\color{codetype},
  directivestyle=\color{codepre},
  commentstyle=\color{codecomment}\itshape,
  stringstyle=\color{codestr},
  numberstyle=\scriptsize\color{codecomment},
  numbers=left, numbersep=8pt,
  showstringspaces=false,
  breaklines=true,
  tabsize=4,
  columns=fixed, basewidth=0.55em,
  keepspaces=true,
  upquote=true,
  aboveskip=0pt, belowskip=0pt,
}
\lstset{style=sleman}
%% Dark box with an optional file name bar on top.
%%   \begin{code}{main.c} ... \end{code}
%%   \begin{code}[language=bash,numbers=none]{terminal} ... \end{code}
%%   \begin{code}{} ... \end{code}          (no bar)
\DeclareTCBListing{code}{ O{} m }{%
  listing only,
  listing options={style=sleman,#1},
  enhanced, sharp corners, boxrule=0pt, frame hidden,
  colback=codebg, colbacktitle=codebar, coltitle=codecomment,
  fonttitle=\ttfamily\scriptsize,
  toptitle=1pt, bottomtitle=1pt, lefttitle=8pt,
  left=18pt, right=6pt, top=4pt, bottom=4pt,
  before skip=6pt, after skip=6pt,
  code={\ifblank{#2}{}{\tcbset{title={#2}}}},
}
%% Inline code: \cc{GPIOA->ODR}
\newcommand{\cc}[1]{{\ttfamily\color{brandblue}\detokenize{#1}}}

%% ------- Images ------------------------------------------------------
%% \fig[width]{file}{caption}   (caption may be empty)
\newcommand{\fig}[3][0.6\paperwidth]{
  \begin{center}
    \includegraphics[width=#1,height=0.52\paperheight,keepaspectratio]{#2}\par
    \ifblank{#3}{}{\vspace{3pt}{\footnotesize\color{muted}#3}\par}
  \end{center}
}
%% \source{...}  image credit, bottom right corner.
\newcommand{\source}[1]{
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=south east,inner sep=0pt,text=muted,font=\tiny]
      at ([xshift=-12mm,yshift=9mm]current page.south east) {Source: #1};
  \end{tikzpicture}
}
%% \fullscreen{file}            image filling the whole slide
%% \fullscreen[caption]{file}   with a caption strip at the bottom
\newcommand{\fullscreen}[2][]{
  {\setbeamertemplate{background}{
     \begin{tikzpicture}
       \useasboundingbox (0,0) rectangle (\paperwidth,\paperheight);
       \fill[black] (0,0) rectangle (\paperwidth,\paperheight);
       \node[inner sep=0pt] at (0.5\paperwidth,0.5\paperheight)
         {\includegraphics[width=\paperwidth,height=\paperheight,
                           keepaspectratio]{#2}};
       \ifblank{#1}{}{
         \fill[black,opacity=0.65] (0,0) rectangle (\paperwidth,10mm);
         \node[text=white,font=\small] at (0.5\paperwidth,5mm) {#1};}
     \end{tikzpicture}}
   \begin{frame}[plain]\end{frame}}%
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