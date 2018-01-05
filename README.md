# Colorization-of-Greyscale-Images(MATLAB)
This project implements our(group of two) proposed method for adding colors to grayscale images without human interference in MATLAB. 
In contrast to many previous computer-aided colorizing methods, which require intensive and perfect human interference, 
this method needs only the user to provide a target gray level image for the process of ‘colorization’.
A colorful image of the similar content as the grayscale image is automatically retrieved from the database of images,
as an input source image. Then, the best matching source pixel is determined using luminance and texture matching procedure,
for each pixel of the target image into a perceptually de-correlated color space. Once the best matching source pixel is found,
its chromaticity values are assigned to the target pixel while the original luminance value of the target pixel is retained.
