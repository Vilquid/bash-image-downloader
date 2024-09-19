#!/bin/bash


curl -s https://multimediatoulon.myportfolio.com/photos-de-classes -o page.html
grep -oP '(http|https)://[^"]+\.(jpg|png)' page.html > images.txt
rm page.html
sed 's/,/\n/g' images.txt > images2.txt
rm images.txt
sed 's/ /\n/g' images2.txt > images.txt
rm images2.txt
grep -E '\.jpg|\.png' images.txt > images_filtered.txt
rm images.txt
xargs -n 1 curl -O < images_filtered.txt
rm images_filtered.txt
find . -maxdepth 1 -type f ! -name "*.jpg" ! -name "*.sh" ! -name "*.png" -exec mv {} {}.jpg \;
