clc;    clear all;  close all;
image = imread('cameraman.tif');
%image = rgb2gray(image);
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
maskSize = 3;
mask = [1 2 1; 2 4 2; 1 2 1];
middlePixel = 0.5*(maskSize - 1);
avgImage = image;
for i = 1+middlePixel:1:rows-middlePixel
    for j = 1+middlePixel:1:columns-middlePixel
        avgImage(i,j) = 0;
        for k = 1:1:maskSize
            for l = 1:1:maskSize
                avgImage(i,j) = avgImage(i,j) + (mask(k,l)*image((i+k)-(1+middlePixel), (j+l)-(1+middlePixel)));
            end
        end
        avgImage(i,j) = avgImage(i,j)/16;
    end
end
avgImage = avgImage - min(min(avgImage));
avgImage = (255*avgImage)/max(max(avgImage));
avgImage = uint8(avgImage);
imshow(avgImage);
fprintf('Gaussian Filtered Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(avgImage, 'D:\Pattern Recognition\My Material\Matlab Codes\Gaussian_Filtered_Image.jpg');
fprintf('Image saved as Gaussian_Filtered_Image.jpg\n');