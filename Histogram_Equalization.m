clc;    clear all;  close all;
image=imread('IceAge.jpg');
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image = rgb2gray(image);
imshow(image);
fprintf('Image after converting to Gray Scale.\nProgram Paused! Press Enter to Continue...\n');
pause;
image = double(image);
[rows, columns] = size(image);
histogram = zeros(1, 256);
for i = 1:1:rows
    for j = 1:1:columns
        currentPixel = image(i, j);
        histogram(currentPixel + 1) = histogram(currentPixel + 1) + 1;
    end
end
histogram = histogram./(rows * columns);
s = zeros(1, 256);
s(1) = histogram(1);
for i = 2:1:256
    s(i) = s(i - 1) + histogram(i);
end
s = s * 255;
newImage = zeros(rows, columns);
for i = 1:1:rows
    for j = 1:1:columns
        newImage(i,j) = s(image(i,j)+1);
    end
end
newImage = uint8(newImage);
imshow(newImage);
fprintf('Histogram Equalized Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(image, 'D:\Pattern Recognition\My Material\Matlab Codes\Histogram_Equalized_Image.jpg');
fprintf('Image saved as Histogram_Equalized_Image.jpg\n');