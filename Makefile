all: results.pdf

%.pdf: %.tex
	xelatex $(<F); biber $(*F); xelatex $(<F); xelatex $(<F)

%.tex: %.Rnw
	Rscript -e 'require(knitr); knit("$(<F)")'
