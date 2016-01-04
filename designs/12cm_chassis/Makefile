# Makefile to create preview HTML from Asciidoc files.

DOC_FILES = $(wildcard *.asciidoc)
HTML_FILES = $(DOC_FILES:.asciidoc=.html)

%.html: %.asciidoc
	asciidoctor -o $@ $<

all: $(HTML_FILES)
