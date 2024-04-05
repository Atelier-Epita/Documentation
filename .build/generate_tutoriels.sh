#!/bin/bash

mkdir -p out
cd tutoriels

for file in *.md; do
    pandoc -s -f markdown-implicit_figures "$file" -H ../.build/header.tex -o "../out/${file%.md}.pdf"
    echo "Generated ${file%.md}.pdf"
done
