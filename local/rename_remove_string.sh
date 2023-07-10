#!/bin/sh

for file in *; do
	ext=.${file##*.}
	no_upscayl=${file%%_*}
	mv "$file" "$no_upscayl$ext"
done
