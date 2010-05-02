#!/bin/sh

cd ./scripts && find . -type f -name "*.scpt" -exec osacompile -o ../build/{} {} \;
