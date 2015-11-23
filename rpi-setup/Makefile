# Makefile to create local HTML previews for .asciidoc files.

%.html: %.asciidoc
	asciidoctor -o $@ $<

PREVIEW_FILES=\
  ros-jade-install.html

all: $(PREVIEW_FILES)
