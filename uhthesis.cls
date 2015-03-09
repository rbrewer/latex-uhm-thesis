%%
%% This is file `uhthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% uhthesis.dtx  (with options: `class')
%% This is an automatically generated file.
%% 
%% This file is part of the uhthesis latex class. It is based partially on the
%% dtx tutorial by Scott Pakin (Copyright 2004) and the uhthesis2e class file by
%% Carleton A. Moore and Robert S. Brewer (Copyright 1998). Additional changes by
%% Mark L. Stillwell (Copyright 2008).
%% 
%% This program is free software: you can redistribute it and/or modify it under
%% the terms of the GNU General Public License as published by the Free Software
%% Foundation, either version 3 of the License, or (at your option) any later
%% version.
%% 
%% This program is distributed in the hope that it will be useful, but WITHOUT
%% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
%% FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License along with
%% this program.  If not, see <http://www.gnu.org/licenses/>.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uhthesis}
    [2015/03/09 v2.2.0 uhthesis class]
\newcommand{\@onehalfspacingp}{false}
\newcommand{\@draftp}{false}
\newcommand{\@englishp}{false}
\newcommand{\@letterpaperp}{false}
\newcommand{\@proposalp}{false}
\newcommand{\@thesisp}{false}
\newcommand{\@twosidep}{false}
\DeclareOption{actual}{}
\DeclareOption{dissertation}{}
\DeclareOption{onehalfspacing}{
    \renewcommand{\@onehalfspacingp}{true}
    \PassOptionsToPackage{\CurrentOption}{setspace}
}
\DeclareOption{draft}{
    \renewcommand{\@draftp}{true}
    \PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{english}{\renewcommand{\@englishp}{true}}
\DeclareOption{hawaiian}{
    \ClassErrorNoLine{uhthesis}
        {The ``hawaiian'' option is not supported at this time}}
\DeclareOption{letterpaper}{
    \renewcommand{\@letterpaperp}{true}
    \PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{proposal}{\renewcommand{\@proposalp}{true}}
\DeclareOption{singlespacing}{\PassOptionsToPackage{\CurrentOption}{setspace}}
\DeclareOption{subfigure}{\PassOptionsToPackage{\CurrentOption}{tocloft}}
\DeclareOption{thesis}{\renewcommand{\@thesisp}{true}}
\DeclareOption{dissertation}{\renewcommand{\@thesisp}{false}}
\DeclareOption{twocolumn}{
    \OptionNotUsed
    \ClassWarningNoLine{uhthesis}{This class does not support the two column format}
}
\DeclareOption{twoside}{
    \renewcommand{\@twosidep}{true}
    \PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions
    {11pt,actual,onehalfspacing,letterpaper,onecolumn,oneside,final,thesis}
\ProcessOptions\relax
\LoadClass[onecolumn]{report}
\RequirePackage{ifthen}
\ifthenelse{\boolean{\@draftp}}{}{
    \ifthenelse{\boolean{\@onehalfspacingp}}{}{
        \ClassWarningNoLine{uhthesis}{final drafts should be 1.5 spaced}
    }
    \ifthenelse{\boolean{\@letterpaperp}}{}{
        \ClassWarningNoLine{uhthesis}
            {final drafts should be printed on letter paper}
    }
    \ifthenelse{\boolean{\@twosidep}}{
        \ClassWarningNoLine{uhthesis}
            {final drafts should be printed on only one side}
    }{}
}
\RequirePackage[left=1.0in, right=1.0in, top=1.0in, bottom=1.0in,
    includefoot]{geometry}
\RequirePackage{setspace}
\newcommand{\acknowledgname}{Acknowledgments}
\newcommand{\prefacename}{Preface}
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}
\renewcommand{\bibname}{Bibliography}
\renewcommand{\indexname}{Index}
\renewcommand{\figurename}{Figure}
\renewcommand{\tablename}{Table}
\renewcommand{\chaptername}{Chapter}
\renewcommand{\appendixname}{Appendix}
\renewcommand{\partname}{Part}
\renewcommand{\abstractname}{Abstract}
\renewcommand{\acknowledgname}{Acknowledgments}
\renewcommand{\@makechapterhead}[1]{
    \begin{Large}
    \begin{bf}
    \begin{singlespacing}
    \begin{center}
        \MakeUppercase{\@chapapp}~\thechapter\par
        \MakeUppercase{#1}\par
        ~\par
    \end{center}
    \end{singlespacing}
    \end{bf}
    \end{Large}
}
\renewcommand{\@makeschapterhead}[1]{
    \begin{Large}
    \begin{bf}
    \begin{singlespacing}
    \begin{center}
        \MakeUppercase{#1}\par
        ~\par
    \end{center}
    \end{singlespacing}
    \end{bf}
    \end{Large}
}
\newcommand{\@degreemonth}{May}
\newcommand{\degreemonth}[1]{\renewcommand{\@degreemonth}{#1}}
\newcommand{\@degreeyear}{2015}
\newcommand{\degreeyear}[1]{\renewcommand{\@degreeyear}{#1}}
\newcommand{\@degree}{Master of Science}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}
\newcommand{\@versionnum}{1.0.0}
\newcommand{\versionnum}[1]{\renewcommand{\@versionnum}{#1}}
\newcommand{\@chair}{No Such Person}
\newcommand{\chair}[1]{\renewcommand{\@chair}{#1}}
\newcommand{\@othermembers}{}
\newcommand{\othermembers}[1]{\renewcommand{\@othermembers}{#1}}
\newcommand{\@field}{}
\newcommand{\field}[1]{\renewcommand{\@field}{#1}}
\newcommand{\@subfield}{}
\newcommand{\subfield}[1]{\renewcommand{\@subfield}{#1}}
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{%
    \ifthenelse{\equal{#1}{}}%
    {}%
    {Keywords: #1}%
}}
\newenvironment{frontmatter}{
    \pagenumbering{roman}
    \setcounter{page}{2}
}{
    \pagenumbering{arabic}
    \setcounter{page}{1}
}
\newcommand{\@papertype}{}
\ifthenelse{\boolean{\@thesisp}}{
    \renewcommand{\@papertype}{Thesis}
}{
    \renewcommand{\@papertype}{Dissertation}
}
\renewcommand{\maketitle}{
    \thispagestyle{empty}
    \large
    \begin{singlespacing}
    \begin{center}
        \null\vspace{3ex}\par
        \MakeUppercase{\@title}\par
        \vspace{1in}\par
        \ifthenelse{\boolean{\@proposalp}}{
            A \MakeUppercase{\@papertype} PROPOSAL SUBMITTED TO MY COMMITTEE\par
        }{
            A \MakeUppercase{\@papertype} SUBMITTED TO THE GRADUATE DIVISION OF THE\par
            UNIVERSITY OF HAWAI`I AT M{\=A}NOA%
        }
        IN PARTIAL FULFILLMENT\par
        OF THE REQUIREMENTS FOR THE DEGREE OF\par
        \vspace{2ex}\par
        \MakeUppercase{\@degree}\par
        \vspace{2ex}\par
        IN\par
        \vspace{2ex}\par
        \MakeUppercase{\@field}
        \ifthenelse{\equal{\@subfield}{}}{}{(\MakeUppercase{\@subfield})}\par
        \vspace{2ex}\par
        \ifthenelse{\boolean{\@proposalp}}{
            \par
        }{
            \vspace{1ex}\par
            \MakeUppercase{\@degreemonth~\@degreeyear}\par
        }
        \vfill\par
        By\par
        \vspace{1ex}\par
        \@author\par
        \vspace{2ex}\par
        \@papertype~Committee:\par
        \vspace{1ex}\par
        \@chair, Chairperson\par
        \@othermembers\par
        \vspace{3ex}\par
        \@keywords\par
        \ifthenelse{\boolean{\@proposalp}\or\boolean{\@draftp}}{
            \vspace{2ex}\par
            \today\par
            Version \@versionnum
        }{}
    \end{center}
    \end{singlespacing}
    \normalsize
    \cleardoublepage
}
\newcommand{\copyrightpage}{
    \large
        \null\vspace{0.45\textheight}\par
        {\centering
        Copyright \copyright{} {\@degreeyear} by \par
        \@author\par
        }
    \normalsize
    \cleardoublepage
}
\renewenvironment{abstract}{
    \chapter*{\abstractname}
    \addcontentsline{toc}{chapter}{\abstractname}
}{
    \cleardoublepage
}
\newenvironment{dedication}{}{
    \cleardoublepage
}
\newenvironment{acknowledgments}{
    \chapter*{\acknowledgname}
    \addcontentsline{toc}{chapter}{\acknowledgname}
}{
    \cleardoublepage
}
\newenvironment{preface}{
    \chapter*{\prefacename}
    \addcontentsline{toc}{chapter}{\prefacename}
}{
    \cleardoublepage
}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[titles]{tocloft}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\AtBeginDocument{
    \let\origtableofcontents\tableofcontents
    \renewcommand{\tableofcontents}{
        \begin{singlespacing}
            \setlength{\parskip}{\baselineskip}
            \setlength{\cftbeforechapskip}{0pt}
            \origtableofcontents
        \end{singlespacing}
        \cleardoublepage
    }
    \let\origlistoftables\listoftables
    \renewcommand{\listoftables}{
        \begin{singlespacing}
            \setlength{\parskip}{\baselineskip}
            \origlistoftables
        \end{singlespacing}
        \cleardoublepage
    }
    \let\origlistoffigures\listoffigures
    \renewcommand{\listoffigures}{
        \begin{singlespacing}
            \setlength{\parskip}{\baselineskip}
            \setlength{\cftbeforechapskip}{0pt}
            \origlistoffigures
        \end{singlespacing}
        \cleardoublepage
    }
}
\endinput
%%
%% End of file `uhthesis.cls'.
