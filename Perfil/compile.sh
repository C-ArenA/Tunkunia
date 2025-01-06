#!/bin/bash

cd $(dirname "$0")

mkdir luabuild
echo "lualatex..."
lualatex --output-directory=luabuild main.tex > ./luabuild/lualatex.log
echo "biber..."
biber --output-directory=luabuild main > ./luabuild/biber.log
echo "lualatex..."
lualatex --output-directory=luabuild main.tex > ./luabuild/lualatex.log
echo "lualatex..."
lualatex --output-directory=luabuild main.tex > ./luabuild/lualatex.log

# latexindent -l -w -c=./latexindent sections/*
# latexindent -l -w -c=./latexindent main.tex
# latexindent -l -w -c=./latexindent cover.tex