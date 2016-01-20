clc;    clear all;  close all;
image = imread('circuit.tif');
%image = rgb2gray(image);
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
maskSize = input('Enter Mask Size:\n');
middlePixel = 0.5*(maskSize - 1);
avgImage = image;
for i = 1+middlePixel:1:rows-middlePixel
    for j = 1+middlePixel:1:columns-middlePixel
        avgImage(i,j) = median(median(image(i-middlePixel:i+middlePixel, j-middlePixel:j+middlePixel)));
    end
end
avgImage = avgImage - min(min(avgImage));
avgImage = (255*avgImage)/max(max(avgImage));
avgImage = uint8(avgImage);
imshow(avgImage);
fprintf('Median Filtered Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
%imwrite(avgImage, 'D:\Pattern Recognition\My Material\Matlab Codes\Median_Filtered_Image.jpg');
fprintf('Image saved as Median_Filtered_Image.jpg\n');