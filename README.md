# image-resizer
A bash script that creates an 800 kb and 400 kb version of high-quality images for responsive websites.

## Pre-requisites
The script requires **ImageMagick** to be installed on your system.
You can find the installation instructions for your platform at [imagemagick.org](https://imagemagick.org/script/download.php).

## Script Description
`resize_images.sh` is a Bash script that uses ImageMagick to resize and compress images.
It generates two additional versions of each input image: a medium version and a thumbnail version.
The medium version has half the dimensions of the original image, while the thumbnail version has a quarter of the original dimensions.
The script also ensures that the medium version does not exceed 800 KB in file size, and the thumbnail version does not exceed 400 KB.

## How it works:
- The script takes an input image file as an argument.
- It extracts the dimensions (width and height) of the input image using ImageMagick's identify command.
- It calculates the dimensions for the medium and thumbnail versions by dividing the original dimensions by 2 and 4, respectively.
- It resizes and compresses the input image using ImageMagick's convert command, ensuring the output file sizes do not exceed the specified limits (800 KB for medium and 400 KB for thumbnail).
- If the output file sizes exceed the limits, the script iteratively reduces the dimensions and compresses the images until they meet the size requirements.

## How to run:
1. Make sure the script is executable:
`chmod +x resize_images.sh`
2. To run the script for a single image file (e.g., example.jpg), execute the following command in the terminal:
`./resize_images.sh example.jpg`
3. To run the script for all image files (jpg, jpeg, and png) in the current directory, execute the following command:
`find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec ./resize_images.sh {} \;`
4. If you want to restrict the search to the current directory only (excluding subdirectories), you can modify the command like this:
`find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec ./resize_images.sh {} \;`