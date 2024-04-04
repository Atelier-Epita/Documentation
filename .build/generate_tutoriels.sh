#!/bin/bash

mkdir -p out
cd tutoriels

for file in *.md; do
    pandoc -f markdown-implicit_figures -V toc "$file" --include-in-header=../.build/template.tex -o "../out/${file%.md}.pdf"
    echo "Generated ${file%.md}.pdf"
done
