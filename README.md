UH Manoa LaTeX Thesis Class Versions
------------------------------------
This README describes version 2.1.0 of the uhthesis class.

This LaTeX class was originally developed in 2000, and has been used by many
theses and dissertations successfully accepted by UHM Graduate Division since
then. The original class was called "uhthesis2e", showing it's age since it was
adapted for LaTeX 2e, back when that was new. This version of the class was
somewhat hacked together, which sometimes caused problems with more modern
LaTeX packages.

In 2008, Mark Stillwell undertook a complete rewrite of the class, starting
from the standard report class. The goal was to provide a clean foundation for
future maintenance, and ensure it worked properly with modern LaTeX packages.
Further, he documented the class definition extensively, referring back to the
style guide point by point. This new class is called "uhthesis",
distinguishing it from the original class.

The new thesis class has been used to successfully submit dissertations to
Graduate Division, most recently in May 2013. However, it was based on the
2010 UH thesis style guide, and now there is a 2014 version of the style
guide. It will need to be modified for theses submitted under the new
guidelines.


Instructions
------------
This archive contains everything necessary to prepare a University of Hawaii
thesis or dissertation with a recent LaTeX2e environment like TeX Live. For
information on how do download LaTeX distributions, go to <http://www.tug.org/>

This class is hosted at GitHub:

<https://github.com/rbrewer/latex-uhm-thesis/>

For assistance with this package, please visit the associated Google Group:

<http://groups.google.com/group/latex-uhm-thesis-discuss>

The following files should be placed in your personal or departmental LaTeX
style directory:

uhthesis.cls	Document class file

For example, on MacTeX you could create the directory
/usr/local/texlive/texmf-local/tex/latex/uhthesis and copy the class file
above into that directory to allow all users on the computer access to the
class. If you only need the class file to be accessible by yourself, you
could create ~/Library/texmf/tex/latex/uhthesis (all the directories after
"Library" will have to be created) and then copy class file in. A similar
procedure should work for other TeX Live distributions.

The class file is documented in uhthesis.pdf

An example of how to use the style with extensive comments is provided in the
example/ subdirectory. The following files make up this example. Start with
"thesis.tex".

abstract.tex
acknowledgments.tex
appendix.tex
body.tex
dedication.tex
example-figure.eps
example.bib
thesis.tex


Development
-----------
The class file is written as a Documented LaTeX source file (.dtx). This
combines the LaTeX code and the documentation in one file. If you want to
modify the class file or documentation, edit the uhthesis.dtx file. When you
want to generate the class file, run "pdflatex uhthesis.ins". The
uhthesis.dtx file can be run through pdflatex like any other document to
generate the documentation for the class.

Good luck! You can report bugs or wonderful new features you have implemented
to the Google Group discussed above.
