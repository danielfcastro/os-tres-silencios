all: pdf
pdf:
	latexmk -pdf main.tex
clean:
	latexmk -C
deepclean:
	rm -rf _build dist
