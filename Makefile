DOC      := example
BUILD    := build
LATEX    := pdflatex
LATEXOPT := -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=$(BUILD)

.PHONY: all view clean

all: $(BUILD)/$(DOC).pdf

$(BUILD)/$(DOC).pdf: $(DOC).tex slemanslides.cls $(wildcard img/*) | $(BUILD)
	$(LATEX) $(LATEXOPT) $(DOC).tex
	$(LATEX) $(LATEXOPT) $(DOC).tex

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
