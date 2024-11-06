# bash-image-downloader

This Bash script downloads all `.jpg` and `.png` images from a specified web page and saves them to your local directory.

## Description

The script performs the following steps:
1. Download web page : Fetches the HTML content of the web page.
2. Extract image URLs : Parses the HTML to find all image URLs ending with .jpg or .png.
3. Clean and filter URLs : Processes the extracted URLs to ensure they are properly formatted.
4. Download images : Downloads each image using curl.
5. Rename files : Renames any downloaded files without an extension to have a .jpg extension.

## Prerequisites

Operating System: Unix-like (Linux, macOS)

Required tools: `curl`, `grep`, `sed`, `xargs`, `find`

## Usage

```bash
git clone https://github.com/Vilquid/bash-image-downloader.git
cd bash-image-downloader
chmod +x script.sh
./script.sh
```

*By default, the script targets https://multimediatoulon.myportfolio.com/caddie. To change the target URL, edit the script and replace the URL in the curl command.*

## How it works

1. Download the web page
   ```bash
   curl -s https://multimediatoulon.myportfolio.com/caddie -o page.html
   ```
   Downloads the HTML content silently and saves it as page.html.

2. Extract image URLs
    ```bash
    grep -oP '(http|https)://[^"]+\.(jpg|png)' page.html > images.txt
    ```
    Uses a regular expression to find all image URLs ending with .jpg or .png.

3. Clean and filter URLs
    ```bash
    sed 's/,/\n/g' images.txt > images2.txt
    sed 's/ /\n/g' images2.txt > images.txt
    grep -E '\.jpg|\.png' images.txt > images_filtered.txt
    ```
    Replaces commas and spaces with newlines and filters out any non-image URLs.

4. Download images:
    ```bash
    xargs -n 1 curl -O < images_filtered.txt
    ```
    Downloads each image URL listed in images_filtered.txt.

5. Rename files without extensions:
    ```bash
    find . -maxdepth 1 -type f ! -name "*.jpg" ! -name "*.sh" ! -name "*.png" -exec mv {} {}.jpg \;
    ```
    Appends .jpg to files that lack an extension.

## Cleanup

Temporary files created during the execution are removed automatically :
- page.html
- images.txt
- images2.txt
- images_filtered.txt

## Notes

- Permissions : Ensure you have the necessary permissions to download and use the images from the target website.
- Customization : Feel free to modify the script to suit your needs, such as changing the target URL or file types.
- Error handling : The script assumes that the web page and URLs are accessible and correct. Additional error handling can be added for robustness.

## Disclaimer

Use this script responsibly. Respect the website's terms of service and avoid violating any copyright laws. The author is not responsible for any misuse of this script.

