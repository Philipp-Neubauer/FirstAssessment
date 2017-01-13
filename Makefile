all: results_compiled.pdf

results_compiled.pdf: results.pdf
	cp results.pdf results_compiled.pdf

results.pdf: results.tex
	xelatex $(<F) ; biber $(<:%.tex=%); xelatex $(<F); xelatex $(<F)

%.tex: %.Rnw
	Rscript -e 'require(knitr); knit("$(<F)")'

clean: 
	rm -rf *.log *.bbl *.aux *.blg *.bcf *.run.xml results.tex