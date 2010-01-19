% UHTHESIS2E DOCUMENT CLASS -- Release info is below.
%    for LaTeX version 2e - 9/29/98
%% Adapted from ucthesis.cls document class
%% For original ucthesis documentation, see the end of this file
%%% ====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "uhthesis2e.cls",
%%%     version         = "1.1.0",
%%%     date            = "6 October 2008",
%%%     portedby        = "Carleton A. Moore, Robert S. Brewer",
%%%     address         = "Collaborative Software Development Lab
%%%                        POST Building 307B
%%%                        1680 East-West Road
%%%                        Honolulu, HI 96822
%%%                        USA",
%%%     telephone       = "",
%%%     email           = "latex-uhm-thesis-discuss@googlegroups.com",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX, uhthesis2e",
%%%     supported       = "not supported",
%%%     docstring       = "This file is the main file for the uhthesis2e
%%%                        class, which is intended to meet the requirements
%%%                        for University of Hawaii Masters theses and Ph.D.
%%%                        dissertations. It is an extensive modifcation of the 
%%%                        ucthesis.cls file, which is a direct port to LaTeX2e
%%%                        from UCTHESIS v2.7 by Ethan V. Munson, with no
%%%                        changes other than those for compatibility.
%%%                        
%%%                        This document class was based on the ``Style & Policy
%%%                        Manual For Theses and Dissertations'' provided by
%%%                        the University of Hawaii Graduate Division. The
%%%                        version used says ``Revised February 1998'' inside
%%%                        the title page. If your version of the manual has a
%%%                        more recent revision date, beware (caveat LaTeXtor
%%%                        :)! In any case, it is your responsibility to
%%%                        determine whether this style meets your needs, not
%%%                        ours. It should be pointed out that this document
%%%                        class has yet to be used for a document that has
%%%                        been submitted to the Graduate Division. You have
%%%                        been warned!!
%%%
%%%                        The recommended way to start using this document
%%%                        class is to read the uhtest.tex demo file and use it 
%%%                        as a template for your thesis file."
%%%  }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uhthesis2e}[1998/09/25 CAM & RSB's University of Hawaii Thesis
Class (a modification of University of California Thesis Class)]

%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%
% Option values are now declared first thing.  Defaults are set to
% 11 point, onesided, final (ie not draft) mode, times (font), thesis, and
% actual (ie not proposal) (RSB 9/29/98)
\newcommand\@ptsize{}
\newcommand\@draftmark{}
\newcommand\@usefonttype{}
\newcommand\@thesisp{}
\newcommand\@proposal{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\renewcommand\@draftmark{1}}
\DeclareOption{final}{\renewcommand\@draftmark{0}}
\DeclareOption{cm}{\renewcommand\@usefonttype{0}}
\DeclareOption{times}{\renewcommand\@usefonttype{1}}
\DeclareOption{palatino}{\renewcommand\@usefonttype{2}}
\DeclareOption{newcent}{\renewcommand\@usefonttype{3}}
\DeclareOption{bookman}{\renewcommand\@usefonttype{4}}
\DeclareOption{thesis}{\renewcommand\@thesisp{true}}
\DeclareOption{dissertation}{\renewcommand\@thesisp{false}}
\DeclareOption{actual}{\renewcommand\@proposal{false}}
\DeclareOption{proposal}{\renewcommand\@proposal{true}}
\ExecuteOptions{11pt,oneside,final,times,thesis,actual}


% CHOOSING THE TYPE SIZE:
%
%  The type size option is handled by reading a different file for each
%  size, as follows, to define font size-specific commands:
%       10pt : uht10, 11pt : uht11, 12pt : uht12
%

%  Two-side or one-side printing.
%
% \@twosidefalse               %  Default is one-sided printing.
\def\ds@twoside{\@twosidetrue  %  Defines twoside option.
           \@mparswitchtrue}   %    Marginpars go on outside of page.

% This is a tricky solution to a tough bootstrapping problem.  The
% "draft" option requires the definition of the \ssp macro.  However,
% the \ssp macro requires that the uct1?.clo file has been loaded.  This
% loading is done by the \@options command which also invokes the
% \ds@draft macro.  This was a cyclic dependency in the previous
% version.  To break this dependency, I have made \ds@draft set a marker
% which is later tested to determine whether to actually do the draft
% mode actions.
% 
% Ethan Munson (October 16, 1992)

\def\ds@twocolumn{\@twocolumntrue}

% The \ProcessOptions command causes the execution of every option command
% FOO which is declared and for which the user typed the FOO option in his
% \documentclass.  For every undeclared option BAR there will be a warning 
% message. (BBF 10/31/94)

\ProcessOptions

% We need the ifthen package for some of the fancy automation later on
% RSB 9/15/98

\RequirePackage{ifthen}

% Depending on the options given, switch to PostScript fonts using standard
% styles. Most useful one is times. RSB 9/15/98
\ifnum \@usefonttype = 1
\RequirePackage{times}
\fi
\ifnum \@usefonttype = 2
\RequirePackage{palatino}
\fi
\ifnum \@usefonttype = 3
\RequirePackage{newcent}
\fi
\ifnum \@usefonttype = 4
\RequirePackage{bookman}
\fi

% Finally load the appropriate options file
\input uht1\@ptsize.clo\relax

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.

\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}

% \smallssp is used to produce tabular environments in the small font.
% This is required because single-spacing requires a change in font size.
% \scriptsizessp is a still smaller version of the same thing.

\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}

%  draft option (this is where the draft option is actually implemented)
%
% \overfullrule = 0pt             % Default is don't mark overfull hboxes.
\ifnum \@draftmark = 1
\ssp                              % Single-spaces and
\overfullrule 5pt                 % causes overfull hboxes to be marked.
\fi


% PREPARING A FOREIGN LANGUAGE VERSION:
%
% This document style is for documents prepared in the English language.
% To prepare a version for another language, various English words must
% be replaced.  Many of the English words that required replacement are
% indicated below, where we give the name of the command in which the
% words appear, and which must be redefined, with the actual words
% underlined.
%
% Other English words that need replacement can be found in the macros
% supporting the title and signature pages.
%
% \tableofcontents:
\def\contentsname{Table of Contents}
%                 ~~~~~~~~~~~~~~~~~
%
% \listoffigures:
\def\listfigurename{List of Figures}
%                   ~~~~~~~~~~~~~~~
%
% \listoftables:
\def\listtablename{List of Tables}
%                  ~~~~~~~~~~~~~~
%
% \thebibliography:
\def\bibname{Bibliography}
%            ~~~~~~~~~~~~
%
% \theindex:
\def\indexname{Index}
%              ~~~~~
%
% figure environment:
\def\figurename{Figure}
%               ~~~~~~
%
% table environment:
\def\tablename{Table}
%              ~~~~~
%
% \chapter:
\def\chaptername{Chapter}
%                ~~~~~~~
% \appendix:
\def\appendixname{Appendix}
%                 ~~~~~~~~
% \part
\def\partname{Part}
%             ~~~~
% abstract environment:
\def\abstractname{Abstract}
%                 ~~~~~~~~
%
% acknowledge environment:
\def\acknowledgname{Acknowledgments}
%                   ~~~~~~~~~~~~~~~

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.  

% The month the degree will be officially conferred, capitalized normally
\def\degreemonth#1{\gdef\@degreemonth{#1}}

% The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The full (unabbreviated) name of the degree, capitalized normally
\def\degree#1{\gdef\@degree{#1}}

% version of this draft only appears when in draft mode or a proposal.
\def\@versionnum{1.0.0}
\def\versionnum#1{\gdef\@versionnum{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}}

% The names of your other committee members, one per line
\def\othermembers#1{\gdef\@othermembers{#1}}

% The number of committee members, which affects the number of lines
% on the signature page.
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}

% The name of your degree's field (e.g. Psychology, Computer Science),
% capitalized normally.
\def\field#1{\gdef\@field{#1}}

% \alwayssingle and \endalwayssingle
%
% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\def\alwayssingle{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
     \else \newpage \fi}

\def\endalwayssingle{\if@restonecol\twocolumn \else \newpage \fi}

% \maketitle outputs the complete title page. It requires all the
% above macros. Based on the options provided, it will customize the
% title page: thesis vs. dissertation, proposal vs. actual

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\def\maketitle{
{\ssp
\begin{alwayssingle}
    \let\footnotesize\small
    \let\footnoterule\relax
    \thispagestyle{empty}
    \setcounter{page}{1}

    \null\vfil
    \begin{center}
    \fmfont
    \uppercase\expandafter{\@title} \par
    \bigskip \medskip
    \vspace{6ex}%
    \ifthenelse{\boolean{\@proposal}}{
      \ifthenelse{\boolean{\@thesisp}}{
        A THESIS PROPOSAL SUBMITTED TO MY THESIS COMMITTEE \par}{
        A DISSERTATION PROPOSAL SUBMITTED TO THE GRADUATE DIVISION \par
        OF THE UNIVERSITY OF HAWAI`I IN PARTIAL FULFILLMENT \par
        OF THE REQUIREMENTS FOR THE DEGREE OF \par}
        \bigskip
      \bigskip
      \uppercase\expandafter{\@degree} \par
      \bigskip \medskip
      IN \par
      \bigskip \medskip
      \uppercase\expandafter{\@field} \par}{
      \ifthenelse{\boolean{\@thesisp}}{
        A THESIS SUBMITTED TO THE GRADUATE DIVISION OF THE \par
        UNIVERSITY OF HAWAI`I IN PARTIAL FULFILLMENT \par
        OF THE REQUIREMENTS FOR THE DEGREE OF \par}{
        A DISSERTATION SUBMITTED TO THE GRADUATE DIVISION OF THE \par
        UNIVERSITY OF HAWAI`I IN PARTIAL FULFILLMENT \par
        OF THE REQUIREMENTS FOR THE DEGREE OF \par}
      \bigskip
      \uppercase\expandafter{\@degree} \par
      \bigskip \medskip
      IN \par
      \bigskip \medskip
      \uppercase\expandafter{\@field} \par
      \bigskip \medskip
      \uppercase\expandafter{\@degreemonth~\@degreeyear} \par}
    \bigskip \bigskip \bigskip \bigskip
    By \par
    {\@author} \par
    \bigskip \bigskip
%    \ifthenelse{\boolean{\@proposal}}{}{
      \ifthenelse{\boolean{\@thesisp}}{
        Thesis Committee: \par}{
        Dissertation Committee: \par}
      \bigskip \medskip
      {\@chair}, Chairperson \par
      {\@othermembers} \par
%}
    \ifthenelse{\boolean{\@proposal}}{
      \bigskip
      \bigskip
      \today \par
      Version \@versionnum}{
      \ifnum \@draftmark = 1
      \bigskip
      \bigskip
      \today \par
      Version \@versionnum 
      \fi}
\end{center}
    \vfil\null
\end{alwayssingle}

\setcounter{footnote}{0}
}}

% SIGNATUREPAGE
%
% The \signaturepage macro emits a UH-style signature page ready for
% your committee's signature. This page is only needed for the final
% actual document, so if proposal or draft options have been provided
% then this page will not put output. Therefore it is safe to include
% in the document at all stages and control its presence with the
% options. It requires that the \degree and \field macros have been
% defined.

\def\signaturepage{
\ifthenelse{\boolean{\@proposal}}{}{
    \ifnum \@draftmark = 0
    \begin{alwayssingle}
      \setlength{\rightskip}{1in}
      \setcounter{page}{2}
      \null\vfill
                                %\begin{center}
      \fmfont
      \noindent
      We certify that we have read this
      \ifthenelse{\boolean{\@thesisp}}{thesis}{dissertation}
      and that, in our opinion, it is satisfactory in scope and quality as a
      \ifthenelse{\boolean{\@thesisp}}{thesis}{dissertation} for the degree of
      {\@degree} in {\@field}. \par
      \vspace*{1.5in}
      
      \begin{flushright}
        \setlength{\rightskip}{1in}
        \begin{minipage}{2.7in}
          \begin{center}
            \ifthenelse{\boolean{\@thesisp}}{THESIS}{DISSERTATION} COMMITTEE
            
            \vspace{0.3in}
            \rule{2.5in}{.01in}
            
            \setlength{\baselineskip}{4pt}
            Chairperson
            
            \vspace*{0.5in}
            \rule{2.5in}{.01in}
            
            \vspace{0.5in}
            \rule{2.5in}{.01in}
            
            \ifnum \@numberofmembers > 3
            \vspace{0.5in}
            \rule{2.5in}{.01in}
            \fi
            
            \ifnum \@numberofmembers > 4
            \vspace{0.5in}
            \rule{2.5in}{.01in}
            \fi
            
            \ifnum \@numberofmembers > 5
            \vspace{0.5in}
            \rule{2.5in}{.01in}
            \fi
            
          \end{center}
        \end{minipage}
      \end{flushright}
      \vfill\null
    \end{alwayssingle}
    \fi
    }
  }

% COPYRIGHTPAGE
%
% While it's technically optional, you probably want a copyright page.
% This is a macro, not an environment, because it can be generated
% from the \degreeyear macro.

\def\copyrightpage{
\begin{alwayssingle}
\begin{center}
{\fmfont
\vspace*{7in}
\copyright Copyright \@degreeyear\par
\vspace{.1in}
by\par
\vspace{.1in}
\@author}
\end{center}
\end{alwayssingle}}

% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts.

\def\abstract{
\begin{alwayssingle}
\chapter*{\abstractname}
%\begin{center}
%{\fmfont
%{\bfseries \uppercase\expandafter{\abstractname}}\par
%}\vspace{.1in}
%\end{center}
\addcontentsline{toc}{chapter}{\abstractname}
}

\def\endabstract{\par\vfil\null\end{alwayssingle}
}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}{\begin{alwayssingle}}{\end{alwayssingle}}

% ACKNOWLEDGMENTS
%
% The acknowledgments environment puts a large, bold, centered 
% "Acknowledgments" label at the top of the page.

\newenvironment{acknowledgments}{\begin{alwayssingle}
\chapter*{\acknowledgname}
%\begin{center}
%{\large \bfseries \uppercase\expandafter{\acknowledgname}}
%\end{center}
\addcontentsline{toc}{chapter}{\acknowledgname}
}{\end{alwayssingle}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 2) for the front matter.
% It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).

\newif\if@resttwoside

\newenvironment{frontmatter}{%
\@resttwosidefalse
\if@twoside
        \@resttwosidetrue
        \@twosidefalse
        \fi
\setcounter{page}{2}
\renewcommand{\thepage}{\roman{page}}
\pagestyle{plain}}{\newpage
\if@resttwoside
        \@twosidetrue
        \fi
\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}
\pagestyle{headings}}


%    ****************************************
%    *                LISTS                 *
%    ****************************************
%

% ENUMERATE
%  Enumeration is done with four counters: enumi, enumii, enumiii
%  and enumiv, where enumN controls the numbering of the Nth level
%  enumeration.  The label is generated by the commands \labelenumi
%  ... \labelenumiv.  The expansion of \p@enumN\theenumN defines the
%  output of a \ref command.
%
% 16 Mar 88 -- changed defs of \labelenum... to use \theenum...

\def\labelenumi{\theenumi.}
\def\theenumi{\arabic{enumi}}

\def\labelenumii{(\theenumii)}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}

\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}

\def\labelenumiv{\theenumiv.}
\def\theenumiv{\Alph{enumiv}}
\def\p@enumiv{\p@enumiii\theenumiii}

% ITEMIZE
% Itemization is controlled by four commands: \labelitemi, \labelitemii,
% \labelitemiii, and \labelitemiv, which define the labels of the
% various itemization levels.

\def\labelitemi{$\m@th\bullet$}
\def\labelitemii{\bfseries --}
\def\labelitemiii{$\m@th\ast$}
\def\labelitemiv{$\m@th\cdot$}


% VERSE
%   The verse environment is defined by making clever use of the
%   list environment's parameters.  The user types \\ to end a line.
%   This is implemented by \let'in \\ equal \@centercr.
%
\def\verse{\par\let\\=\@centercr
  \list{}{\ssp\itemsep\z@ \itemindent -1.5em\listparindent \itemindent
          \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist

% QUOTATION
%   Fills lines
%   Indents paragraph
%
\def\quotation{\par\list{}{\ssp\listparindent 1.5em
    \itemindent\listparindent
    \rightmargin\leftmargin\parsep \z@ plus\p@}\item[]}
\let\endquotation=\endlist

% QUOTE -- same as quotation except no paragraph indentation,
%
\def\quote{\par\list{}{\ssp\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist

% DESCRIPTION
%
%  To change the formatting of the label, you must redefine
%  \descriptionlabel.

\def\descriptionlabel#1{\hspace\labelsep \bfseries #1}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
       \let\makelabel\descriptionlabel}}

\let\enddescription\endlist

\newdimen\descriptionmargin
\descriptionmargin=3em


%    ****************************************
%    *         OTHER ENVIRONMENTS           *
%    ****************************************
%
%
% VERBATIM
%
% standard verbatim mode driver macro is modified to use
% single-spacing.  There appears to be a small problem with extra
% vertical space (1 or 2 points worth) after this environment.
% Probably, this results from returning to double-spacing before
% issuing a \parskip, but I'm not enough of TeX hacker to figure out
% the source of the problem. (EVM, 9/25/94)
% 94/11/03 BBF converted \tt to \ttfamily

\def\@verbatim{\trivlist\ssp \item[]\if@minipage\else\vskip\parskip\fi
\leftskip\@totalleftmargin\rightskip\z@
\parindent\z@\parfillskip\@flushglue\parskip\z@
%%RmS 91/08/26 Added \@@par to clear possible \parshape definition
%%from a surrounding list (the verbatim guru says)
\@@par
\@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par
\penalty\interlinepenalty}%
\obeylines \ttfamily \catcode``=13 \@noligs \let\do\@makeother \dospecials}

% ARRAY AND TABULAR
%

\arraycolsep 5pt     % Half the space between columns in an array
                     % environment.
\tabcolsep 6pt       % Half the space between columns in a tabular
                     % environment.
\arrayrulewidth .4pt % Width of rules in array and tabular environment.
\doublerulesep 2pt   % Space between adjacent rules in array or tabular
                     % environment.

% We have to redefine array here in order to make it single-spaced.
% (Not sure if this is really necessary.)
\def\array{\let\@acol\@arrayacol \let\@classz\@arrayclassz
 \let\@classiv\@arrayclassiv \let\\\@arraycr\let\@halignto\@empty\@tabarray}

% TABBING
%
\tabbingsep \labelsep   % Space used by the \' command.
                        %  (See LaTeX manual.)

% We have to redefine tabular here in order to make it single-spaced.
\def\tabular{\par\ssp\let\@halignto\@empty\@tabular}
\expandafter \def\csname tabular*\endcsname #1%
{\par\ssp\def\@halignto{to#1}\@tabular}

% \smalltabular and \smalltabular* are alternative tabular styles
% in the \small font.  They are required because single-spacing implies a 
% change of font to a particular size.
% EVM, 7/20/93 
\def\smalltabular{\par\smallssp\let\@halignto\@empty\@tabular}
\def\endsmalltabular{\endtabular}
\expandafter \def\csname smalltabular*\endcsname #1%
{\par\smallssp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endsmalltabular*\endcsname = \endtabular

% \scriptsizetabular and \scriptsizetabular* are analogs of \smalltabular
\def\scriptsizetabular{\par\scriptsizessp\let\@halignto\@empty\@tabular}
\def\endscriptsizetabular{\endtabular}
\expandafter \def\csname scriptsizetabular*\endcsname #1%
{\par\scriptsizessp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endscriptsizetabular*\endcsname = \endtabular

% MINIPAGE
%  \@minipagerestore is called upon entry to a minipage environment to
%  set up things that are to be handled differently inside a minipage
%  environment. In the current styles, it does nothing.
%
% \skip\@mpfootins : plays same role for footnotes in a minipage as
%                    \skip\footins does for ordinary footnotes

\skip\@mpfootins = \skip\footins

% FRAMEBOX
%
\fboxsep = 3pt    % Space left between box and text by \fbox and
                  % \framebox.
\fboxrule = .4pt  % Width of rules in box made by \fbox and \framebox.


%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
% DEFINE COUNTERS:
%
% \newcounter{NEWCTR}[OLDCTR] : Defines NEWCTR to be a counter, which is
%                               reset to zero when counter OLDCTR is
%                               stepped.
%                               Counter OLDCTR must already be defined.

% Must redefine @startsection so that we always get indentation.
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \@afterindenttrue
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \relax\fi
   \if@nobreak \everypar{}\else
     \addpenalty{\@secpenalty}\addvspace{\@tempskipa}\fi \@ifstar
     {\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

%% Redefine @sect so that the abbreviated name is used only for %%
%% the page heading, and the full name goes into the table of   %%
%% uhthesis2e.cls -- JTW                                        %%

\def\@sect#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
     \let\@svsec\@empty\else
     \refstepcounter{#1}%
     \let\@@protect\protect
     \def\protect{\noexpand\protect\noexpand}%
     \edef\@svsec{\@seccntformat{#1}}%
     \let\protect\@@protect\fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@
        \begingroup #6\relax
          \@hangfrom{\hskip #3\relax\@svsec}%
                    {\interlinepenalty \@M #8\par}%
        \endgroup
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
%%                     #7}\else
                    #8}\else
        \def\@svsechd{#6\hskip #3\relax  %% \relax added 2 May 90
                   \@svsec #8\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                           \protect\numberline{\csname the#1\endcsname}%
                                     \fi
%%                        #7}}\fi
                       #8}}\fi
     \@xsect{#5}}


\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

% For any counter CTR, \theCTR is a macro that defines the printed
% version of counter CTR.  It is defined in terms of the following
% macros:
%
%  \arabic{COUNTER} : The value of COUNTER printed as an arabic numeral.
%  \roman{COUNTER}  : Its value printed as a lower-case roman numberal.
%  \Roman{COUNTER}  : Its value printed as an upper-case roman numberal.
%  \alph{COUNTER}   : Value of COUNTER printed as a lower-case letter:
%                         1 = a, 2 = b, etc.
%  \Alph{COUNTER}   : Value of COUNTER printed as an upper-case letter:
%                           1 = A, 2 = B, etc.
%

\def\thepart          {\Roman{part}}
\def\thechapter       {\arabic{chapter}}
\def\thesection       {\thechapter.\arabic{section}}
\def\thesubsection    {\thesection.\arabic{subsection}}
\def\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\def\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

% \@chapapp is initially defined to be '\chaptername'.  The \appendix
% command redefines it to be '\appendixname'.
%
\def\@chapapp{\chaptername}

%% Kludge to get multiple appendices lettered rather than numbered %%
%% Added by John T. Whelan 1996 June 21                            %%
\newcommand{\appendixon}{
        \def\thesection{\thechapter.\Alph{section}}
        \setcounter{section}{0}
}
\newcommand{\appendixoff}{
        \def\thesection{\thechapter.\arabic{section}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        PART                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\part{\cleardoublepage   % Starts new page.
   \thispagestyle{plain}%    % Page style of part page is 'plain'
  \if@twocolumn              % IF two-column style
     \onecolumn              %  THEN \onecolumn
     \@tempswatrue           %       @tempswa := true
    \else \@tempswafalse     %  ELSE @tempswa := false
  \fi                        % FI
  \hbox{}\vfil               % Add fil glue to center title
%%  \bgroup  \centering      % BEGIN centering %% Removed 19 Jan 88
  \secdef\@part\@spart}

\def\@part[#1]#2{\ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
        \refstepcounter{part}%                    %   THEN step
                                                  %         part counter
        \addcontentsline{toc}{part}{\thepart      %        add toc line
        \hspace{1em}#1}\else                      %   ELSE add
                                                  %         unnumb. line
        \addcontentsline{toc}{part}{#1}\fi        % FI
   \markboth{}{}%
   {\centering                       % %% added 19 Jan 88
    \interlinepenalty \@M            %% RmS added 11 Nov 91
    \ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
      \huge\bfseries \partname~\thepart    %   THEN Print '\partname' and
    \par                             %         number in \huge bold.
    \vskip 20\p@\fi                  %        Add space before title.
    \Huge \bfseries                        % FI
    #2\par}\@endpart}                % Print Title in \Huge bold.
                                     % Bug Fix 13 Nov 89: #1 -> #2


% \@endpart finishes the part page
%
\def\@endpart{\vfil\newpage   % End page with 1fil glue.
   \if@twoside                % IF twoside printing
       \hbox{}%               %   THEN Produce totally blank page
       \thispagestyle{empty}%
       \newpage
   \fi                        % FI
   \if@tempswa                % IF @tempswa = true
     \twocolumn               %   THEN \twocolumn
   \fi}                       % FI

\def\@spart#1{{\centering      % %% added 19 Jan 88
   \interlinepenalty \@M       %% RmS added 11 Nov 91
   \Huge \bfseries                   % Print title in \Huge boldface
   #1\par}\@endpart}





%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************
%
% A \subsection command writes a
%       \contentsline{subsection}{TITLE}{PAGE}
% command on the .toc file, where TITLE contains the contents of the
% entry and PAGE is the page number.  If subsections are being numbered,
% then TITLE will be of the form
%       \numberline{NUM}{HEADING}
% where NUM is the number produced by \thesubsection.  Other sectioning
% commands work similarly.
%
% A \caption command in a 'figure' environment writes
%    \contentsline{figure}{\numberline{NUM}{CAPTION}}{PAGE}
% on the .lof file, where NUM is the number produced by \thefigure and
% CAPTION is the figure caption.  It works similarly for a 'table'
% environment.
%
% The command \contentsline{NAME} expands to \l@NAME.  So, to specify
% the table of contents, we must define \l@chapter, \l@section,
% \l@subsection, ... ; to specify the list of figures, we must define
% \l@figure; and so on.  Most of these can be defined with the
% \@dottedtocline command, which works as follows.
%
% \@dottedtocline{LEVEL}{INDENT}{NUMWIDTH}{TITLE}{PAGE}
%    LEVEL    : An entry is produced only if LEVEL < or = value of
%               'tocdepth' counter.  Note, \chapter is level 0, \section
%               is level 1, etc.
%    INDENT   : The indentation from the outer left margin of the start
%               of the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command.
%
% This command uses the following three parameters, which are set
% with a \def (so em's can be used to make them depend upon the font).
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for multiple line entries.  One
%                 wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be
%                 \def'd to a number like 2 or 1.7

\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}


% TABLEOFCONTENTS
%  In ucthesis style, \tableofcontents, \listoffigures, etc. are always
%  set in single-column style.  @restonecol

\def\tableofcontents{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\contentsname
        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}}%
  {\ssp\@starttoc{toc}}\if@restonecol\twocolumn\fi}

\def\l@part#1#2{\addpenalty{-\@highpenalty}%
   \addvspace{2.25em plus\p@}% space above part line
   \begingroup
   \@tempdima 3em         % width of box holding part number, used by
     \parindent \z@ \rightskip \@pnumwidth             %% \numberline
     \parfillskip -\@pnumwidth
     {\large \bfseries          % set line in \large boldface
     \leavevmode          % TeX command to enter horizontal mode.
     #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
     \nobreak             % Never break after part entry
    \global\@nobreaktrue                        %% Added 24 May 89 as
    \everypar{\global\@nobreakfalse\everypar{}}%% suggested by
                                               %% Jerry Leichter
   \endgroup}

%% First line of l@chapter changed 24 May 89, as suggested
%% by Jerry Leichter.
%%
%\def\l@chapter#1#2{\addpenalty{-\@highpenalty}%
%   \vskip 1.0em plus\p@   % space above chapter line
%   \@tempdima 1.5em       % width of box holding chapter number
%   \begingroup
%     \parindent \z@ \rightskip \@pnumwidth
%     \parfillskip -\@pnumwidth
%     \bfseries                  % Boldface.
%     \leavevmode          % TeX command to enter horizontal mode.
%      \advance\leftskip\@tempdima  %% added 5 Feb 88 to conform to
%      \hskip -\leftskip            %% 25 Jan 88 change to \numberline
%     #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
%     \penalty\@highpenalty %% added 24 May 89, suggested by J. Leichter
%   \endgroup}
\def\l@chapter{\@dottedtocline{0}{0.1em}{1.4em}}
\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

% LIST OF FIGURES
%
% Single-space list of figures, add it to the table of contents.
\def\listoffigures{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listfigurename\@mkboth{\uppercase{\listfigurename}}%
{\uppercase{\listfigurename}}}
\addcontentsline{toc}{chapter}{\listfigurename}

% ACK! This is a hyper-bletcherous hack to get the headings in the right
% place. Presumably a TeXpert would have an elegant way to do this. RSB 3/14/00
\hspace{-0.515in} \underline{\figurename} \hspace{5.2in} \underline{Page}

   {\ssp\@starttoc{lof}}\if@restonecol
    \twocolumn\fi}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

% LIST OF TABLES
%
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
   {\uppercase{\listtablename}}}\@starttoc{lot}\if@restonecol
  \twocolumn\fi}
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
{\uppercase{\listtablename}}}
   \addcontentsline{toc}{chapter}{\listtablename}

% ACK! This is a hyper-bletcherous hack to get the headings in the right
% place. Presumably a TeXpert would have an elegant way to do this. RSB 3/14/00
\hspace{-0.48in} \underline{\tablename} \hspace{5.21in} \underline{Page}

   {\ssp\@starttoc{lot}}\if@restonecol
  \twocolumn\fi}

\let\l@table\l@figure



%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
% The thebibliography environment executes the following commands:
%
%  \def\newblock{\hskip .11em plus .33em minus .07em} --
%      Defines the `closed' format, where the blocks (major units of
%      information) of an entry run together.
%
%  \sloppy  -- Used because it's rather hard to do line breaks in
%      bibliographies,
%
%  \sfcode`\.=1000\relax --
%      Causes a `.' (period) not toproduce an end-of-sentence space.

%% RmS 91/10/27 [ .. ] replaced by \@biblabel{ .. }
%% RmS 91/11/13: Changed counter enumi to enumiv,
%%               as it says in the comment in latex.tex
%% RmS 92/01/14: Set \p@enumiv to {} and \theenumiv to \arabic{enumiv}
%%               to get correct references
\def\thebibliography#1{\chapter*{\bibname\@mkboth{%
\uppercase{\bibname}}{\uppercase{\bibname}}}
  \addcontentsline{toc}{chapter}{\bibname}
  \list{\@biblabel{\arabic{enumiv}}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m}


%% 91/08/26 FMI & RmS: introduced warning instead of error

\def\endthebibliography{%
  \def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
  \endlist}


% \def\@biblabel#1{[#1]\hfill}  % Produces the label for a \bibitem[...]
                                % command.
% \def\@cite#1{[#1]}            % Produces the output of the \cite
                                % command.



%    ****************************************
%    *              THE INDEX               *
%    ****************************************
%
% THE THEINDEX ENVIRONMENT
% Produces double column format, with each paragraph a separate entry.
% The user commands \item, \subitem and \subsubitem are used to
% produce the entries, and \indexspace adds an extra vertical space
% that's the right size to put above the first entry with a new letter
% of the alphabet.

\newif\if@restonecol

\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@
\columnsep 35\p@\twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\uppercase{\indexname}}{\uppercase{\indexname}}%
    \thispagestyle{plain}\parindent\z@
    \parskip\z@ plus .3\p@\relax\let\item\@idxitem}

\def\@idxitem{\par\hangindent 40\p@}

\def\subitem{\par\hangindent 40\p@ \hspace*{20\p@}}

\def\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}

\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}

\def\indexspace{\par \vskip 10\p@ plus5\p@ minus3\p@\relax}


%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
% \footnoterule is a macro to draw the rule separating the footnotes
% from the text.  It should take zero vertical space, so it needs a
% negative skip to compensate for any positive space taken by the rule.
% (See PLAIN.TEX.)

\def\footnoterule{\kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}                 % The \hrule has default height of .4pt.

% \newcounter{footnote}
\@addtoreset{footnote}{chapter}  % Numbers footnotes within chapters

%   \@makefntext{NOTE} :
%        Must produce the actual footnote, using \@thefnmark as the mark
%        of the footnote and NOTE as the text.  It is called when
%        effectively inside a \parbox of width \columnwidth (i.e., with
%        \hsize = \columnwidth).
%
%        The following macro indents all lines of the footnote by 10pt,
%        and indents the first line of a new paragraph by 1em.  To
%        change these dimensions, just substitute the desired value for
%        '10pt' [in both places] or '1em'.  The mark is flushright
%        against the footnote.
%          \long\def\@makefntext#1{\@setpar{\@@par\@tempdima \hsize
%             \advance\@tempdima-10pt\parshape \@ne 10pt \@tempdima}\par
%             \parindent 1em\noindent
%             \hbox to \z@{\hss$\m@th^{\@thefnmark}$}#1}
%
%        A simpler macro is used, in which the footnote text is
%        set like an ordinary text paragraph, with no indentation except
%        on the first line of a paragraph, and the first line of the
%        footnote.  Thus, all the macro must do is set \parindent
%        to the appropriate value for succeeding paragraphs and put the
%        proper indentation before mark.

\long\def\@makefntext#1{\parindent 1em\noindent
            \hbox to 1.8em{\hss$\m@th^{\@thefnmark}$}#1}

% \@makefnmark : A macro to generate the footnote marker that goes
%    in the text.  Default used.
%


% Single-space footnotes.
\long\def\@footnotetext#1{\insert\footins{\ssp\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}
 
%    ****************************************
%    *         FIGURES AND TABLES           *
%    ****************************************
%
% Float placement parameters.  See LaTeX manual for their definition.
%
\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.
%      NUMBER : Figure or table number--e.g., 'Figure 3.2'
%      TEXT   : The caption text.
%  Macro should be called inside a \parbox of right width, with
%  \normalsize.
% changed 25 Jun 86 to fix according to Howard Trickey:
% instead of \unhbox\@tempboxa\par we do #1: #2\par

% 15 Nov 93: further changes to support captions BEFORE the figure
% or table.  Changes suggested by Donald Arseneau, installed by Ethan
% Munson.  Detailed reasons are:
%       The \unhbox allows \vadjust material (\vspace) to get out;
%       the \vbox to\topskip{} is for captions at the top of top-floats;
%       the \ifdim is for captions above the figure or table;
%       the strut is for tables below the caption.

\long\def\@makecaption#1#2{% Add space only if something is ...
   \par\ifdim\prevdepth>-\p@ \vskip 10\p@\relax \fi % above the caption
   \setbox\@tempboxa\hbox{\vbox to\topskip{}#1. #2\unskip\strut}% 
   \ifdim \wd\@tempboxa >\hsize      % IF longer than one line:
       {\ssp#1. #2\unskip\strut\par} %   THEN set as ordinary paragraph.
     \else                           %   ELSE  center.
       \hbox to\hsize{\hfil\unhbox\@tempboxa\hfil}%
   \fi}

% To define a float of type TYPE (e.g., TYPE = figure), the document
% style must define the following.
%
%  \fps@TYPE   : The default placement specifier for floats of type
%                TYPE.
%
% \ftype@TYPE : The type number for floats of type TYPE.  Each TYPE
%                has associated a unique positive TYPE NUMBER, which
%                is a power of two.  E.g., figures might have type
%                number 1, tables type number 2, programs type number
%                4, etc.
%
% \ext@TYPE : The file extension indicating the file on which the
%                contents list for float type TYPE is stored.  For
%                example, \ext@figure = 'lof'.
%
%  \fnum@TYPE  : A macro to generate the figure number for a caption.
%                For example, \fnum@TYPE == Figure \thefigure.
%
%  The actual float-making environment commands--e.g., the commands
%  \figure and \endfigure--are defined in terms of the macros \@float
%  and \end@float, which are described below.
%
% \@float{TYPE}[PLACEMENT] : Macro to begin a float environment for a
%     single-column float of type TYPE with PLACEMENT as the placement
%     specifier.  The default value of PLACEMENT is defined by
%     \fps@TYPE.  The environment is ended by \end@float.  E.g.,
%     \figure == \@float{figure}, \endfigure == \end@float.


% FIGURE

\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}

\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\def\figure{\@float{figure}}
\def\endfigure{\end@float}
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}

% TABLE
%
\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\def\table{\@float{table}}
\def\endtable{\end@float}
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}


%    ****************************************
%    *            PAGE STYLES               *
%    ****************************************
%
% The page style 'foo' is defined by defining the command \ps@foo.  This
% command should make only local definitions.  There should be no stray
% spaces in the definition, since they could lead to mysterious extra
% spaces in the output.
%
% The \ps@... command defines the macros \@oddhead, \@oddfoot,
% \@evenhead, and \@evenfoot to define the running heads and
% feet---e.g., \@oddhead is the macro to produce the contents of the
% heading box for odd-numbered pages.  It is called inside an \hbox of
% width \textwidth.
%
% To make headings determined by the sectioning commands, the page style
% defines the commands \chaptermark, \sectionmark, ... , where
% \chaptermark{TEXT} is called by \chapter to set a mark, and so on.
% The \...mark commands and the \...head macros are defined with the
% help of the following macros.  (All the \...mark commands should be
% initialized to no-ops.)
%
% MARKING CONVENTIONS:
% LaTeX extends TeX's \mark facility by producing two kinds of marks
% a 'left' and a 'right' mark, using the following commands:
%     \markboth{LEFT}{RIGHT} : Adds both marks.
%     \markright{RIGHT}      : Adds a 'right' mark.
%     \leftmark  : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'left' mark.
%                  Works like TeX's \botmark command.
%     \rightmark : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'right' mark.
%                  Works like TeX's \firstmark command.
% The marking commands work reasonably well for right marks 'numbered
% within' left marks--e.g., the left mark is changed by a \chapter
% command and the right mark is changed by a \section command.  However,
% it does produce somewhat anomalous results if two \bothmark's occur on
% the same page.
%
%
% Commands like \tableofcontents that should set the marks in some
% page styles use a \@mkboth command, which is \let by the pagestyle
% command (\ps@...)  to \markboth for setting the heading or
% \@gobbletwo to do nothing.

\mark{{}{}}   % Initializes TeX's marks

% \ps@empty defined in LATEX.TEX

% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%
% 91/03/26 FMi: Added extra set of braces arround |\sl| in |\@oddhead|
% to support NFSS (|\sl| is a shape |\rm| a family). Also remove
% unnecessary |\hbox{}| commands.
%
% 94/11/3 BBF: Eliminated two letter font selection commands \rm and \sl
% in favor of \rmfamily and \slshape.
%

\if@twoside         % If two-sided printing.
\def\ps@headings{\let\@mkboth\markboth
  \def\@oddfoot{\rmfamily\hfil\thepage\hfil}  % Simple footer with page number
  \def\@evenfoot{\rmfamily\hfil\thepage\hfil} % Simple footer with page number
  \def\@oddhead{}  % Empty header
  \def\@evenhead{} % Empty header
  \def\chaptermark##1{\markboth {}{}}%
  \def\sectionmark##1{\markright {}}}
\else               % If one-sided printing.
\def\ps@headings{\let\@mkboth\markboth
  \def\@oddfoot{\rmfamily\hfil\thepage\hfil}   % Simple footer with page number
  \def\@evenfoot{\rmfamily\hfil\thepage\hfil}  % Simple footer with page number
  \def\@oddhead{} % Empty header
  \def\chaptermark##1{\markright {}}}
\fi

% Definition of 'myheadings' page style.
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
 \def\@oddhead{{\slshape\rightmark}\hfil \rmfamily\thepage}%
 \def\@oddfoot{}\def\@evenhead{\rmfamily \thepage\hfil\slshape\leftmark}%
 \def\@evenfoot{}\def\chaptermark##1{}\def\sectionmark##1{}%
 \def\subsectionmark##1{}}

% Definition of 'plain' page style.
%
\def\ps@plain{\let\@mkboth\markboth
\def\@oddfoot{\rm\hfil\thepage\hfil}
\def\@evenfoot{\rm\hfil\thepage\hfil}                   % page numbers
                                                        % in feet
\def\@oddhead{}                                         % heading (right)
\def\@evenhead{}}                                       % heading (left)



%    ****************************************
%    *            MISCELLANEOUS             *
%    ****************************************
%
% DATE
%
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

% EQUATION and EQNARRAY -- put here because it must follow \chapter
% definition
%
% \newcounter{equation}
%
%% \@addtoreset{equation}{chapter}   % Makes \chapter reset 'equation'
                                  % counter.

%% \def\theequation{\thechapter.\arabic{equation}}

%% I like section-based equation numbers -- JTW 1996  %%

\def\theequation{\thesection.\arabic{equation}}
\@addtoreset{equation}{section}

% \jot = 3pt      % Extra space added between lines of an eqnarray
                  % environment

% The macro \@eqnnum defines how equation numbers are to appear in
% equations.
%
% \def\@eqnnum{(\theequation)}
%


%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

\ps@headings                   % 'headings' page style
\pagenumbering{arabic}      % Arabic page numbers
\if@twoside\else\raggedbottom\fi % Ragged bottom unless twoside
                                 % option.
\if@twocolumn
 \@@input twocolum.sty\relax
\else
 \onecolumn                 % Single-column.
\fi

\endinput
% UCTHESIS DOCUMENT CLASS -- Release info is below.
%    for LaTeX version 2e - 11/3/94
%% Modifed by John T. Whelan, June 1996, for UCSB use, following
%% Chris Martin's changes to ucthesis.sty
%%% ====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "ucthesis.cls",
%%%     version         = "3.0",
%%%     date            = "31 October 1994",
%%%     portedby        = "Blaise B. Frederick",
%%%     address         = "Center for Functional Imaging
%%%                        Lawrence Berkeley Laboratory
%%%                        MS 55-121
%%%                        1 Cyclotron Rd.
%%%                        Berkeley, CA 94720
%%%                        USA",
%%%     telephone       = "(510) 486-4423",
%%%     email           = "frederic@imasun.lbl.gov",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX, ucthesis",
%%%     supported       = "until November 30, 1994",
%%%     docstring       = "This file is the main file for the ucthesis
%%%                        class, which is intended to meet the requirements
%%%                        for University of California Ph.D. dissertations.
%%%                        It is a direct port to LaTeX2e from UCTHESIS
%%%                        v2.7 by Ethan V. Munson, with no changes other 
%%%                        than those for compatibility.  The major modifictions
%%%                        are in the font selection commands in the option
%%%                        files uct1x.clo.
%%%                        
%%%                        UCTHESIS.STY v2.7 is based on the standard
%%%                        report.sty as modified by Mittelbach and Schopf in
%%%                        Jan 1992.  The primary differences are (1) the use
%%%                        of pseudo-double-spacing, except in certain special
%%%                        environments; and (2) the use of a 6 inch line
%%%                        with 4em paragraph indentation.  It is only
%%%                        intended for single-sided printing.  Double-sided
%%%                        printing may be possible, but you're on
%%%                        your own.
%%%
%%%                        I know of no bugs in this implementation,
%%%                        but would be happy to hear of any problems
%%%                        that arise with it.
%%%
%%%                        Version 2.x fixes a bug in the previous
%%%                        version of 20 Jun 1988.  The bug was that 
%%%                        "draft" optional mode didn't work because of
%%%                        problems in handling optional arguments.
%%%                        This file does not seem to work with earlier 
%%%                        versions of LaTeX (pre-Jan 1992).
%%%
%%%                        Version 2.3 includes a single-spaced 
%%%                        tabular* environment.
%%%                     
%%%                        Version 2.4 sets \evensidemargin correctly
%%%                        for two-sided style.  It also adds new
%%%                        environments (\smalltabular and
%%%                        \scriptsizetabular) which produce tables
%%%                        with smaller fonts.  The obvious methods
%%%                        of producing small-font tables don't work
%%%                        in ucthesis style.
%%%
%%%                        Version 2.5 adds support for the \maketitle
%%%                        macro.
%%%
%%%                        Version 2.6 adds support for complete and
%%%                        correct front matter.  Some dead code was
%%%                        removed, too.
%%%
%%%                        Version 2.7 adds front matter support for
%%%                        thesis committees of more than 3 people
%%%                        and for a labeled signature line on the
%%%                        abstract page.
%%%
%%%                        Version 3.0 is a direct port of version 2.7
%%%                        to LaTeX2e.  The major revisions in ucthesis.cls
%%%                        are converting option processing to LaTeX2e 
%%%                        conventions.  The uct1x files have been revised
%%%                        to use the new font selection commands.
%%%
%%%                        Some users have had problems with the 
%%%                        margins ending up too small on one side.
%%%                        This appears to be a DVI-to-PostScript
%%%                        driver or printer-adjustment problem.
%%%                        If you have such trouble, make small adjustments
%%%                        to the \textwidth and \oddsidemargin
%%%                        settings in your document preamble.
%%%                        
%%%                        Another problem some people have had is
%%%                        that you can't use \pagestyle{headings}
%%%                        and \markboth if you use \part.  The solution
%%%                        is to get the headerfooter style, which is
%%%                        nice and simple to use."
%%%  }
%%% ====================================================================
