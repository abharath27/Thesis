# Author: Arun Chaganty <arunchaganty@gmail.com>
#

# $Id$
FILE = thesis
VERSION=0
OUTPUT = $(shell basename $(PWD))
FIGURES =
SECTIONS = abstract.tex intro.tex background.tex related-work.tex searching-homomorphisms.tex small-world-options.tex conclusions.tex
LATEX=pdflatex --file-line-error --interaction=nonstopmode

all: $(OUTPUT).pdf

$(OUTPUT).pdf: $(FILE).tex ${FIGURES} $(SECTIONS) 
	$(LATEX) $(FILE).tex 
	mv $(FILE).pdf $@

final: $(FILE).tex ${FIGURES} $(SECTIONS)  
	texify < $< > $(FILE)_tmp.tex 
	$(LATEX) $(FILE)_tmp.tex 
	bibtex $(FILE)_tmp
	$(LATEX) $(FILE)_tmp.tex 
	$(LATEX) $(FILE)_tmp.tex 
	mv $(FILE)_tmp.pdf $(OUTPUT).pdf

bib: $(FILE).tex ${FIGURES} $(SECTIONS) 
	$(LATEX) $(FILE).tex 
	bibtex $(FILE)
	$(LATEX) $(FILE).tex 
	$(LATEX) $(FILE).tex 
	mv $(FILE).pdf $(OUTPUT).pdf

version: $(OUTPUT).pdf
	cp $(OUTPUT).pdf  $(OUTPUT)-$(VERSION).pdf

${FIGURES}: %.pdf : %.eps 
	epstopdf --autorotate=All $^

.PHONY: clean bib final version

clean:
	rm -rf *.{aux,dvi,out,bbl,blg,brf,log,toc,loc,lof,lot}
	rm -rf $(FILE)_tmp.tex

