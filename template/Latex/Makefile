
project_name = document

nvim_run: nvim_build
	open -a /Applications/LivePDFviewer.app $(project_name).pdf

nvim_build:
	lualatex $(project_name).tex

clean:
	rm -rf ./*.pdf ./*.log ./*.aux
