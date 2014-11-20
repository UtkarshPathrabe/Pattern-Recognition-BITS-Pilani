clc;    clear all;  close all;
image = imread('10.jpg');
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image = rgb2gray(image);
imshow(image);
fprintf('Image after converting to Gray Scale.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
c = input('Enter the value of c:\n');
modifiedImage = ones(rows, columns);
for i = 1:1:rows
    for j = 1:1:columns
        modifiedImage(i,j) = c*log(1 + image(i,j));
    end
end
modifiedImage = modifiedImage - min(min(modifiedImage));
modifiedImage = (255*modifiedImage)/max(max(modifiedImage));
modifiedImage = uint8(modifiedImage);
imshow(modifiedImage);
fprintf('Image after Log Transformation.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(modifiedImage, 'D:\Pattern Recognition\My Material\Matlab Codes\Log_Transformed_Image.jpg');
fprintf('Image saved as Log_Transformed_Image.jpg\n');