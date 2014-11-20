clc;    clear all;  close all;
image = imread('moon.tif');
%image = rgb2gray(image);
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
fprintf('Enter A = 1 for Laplacian, A = 2 for Unsharp Masking and A>2 for High Boost Filtering.\n');
A = input('Enter the value of A:\n');
mask = [-1, -1, -1; -1, A+7, -1; -1, -1, -1];
avgImage = image;
for i = 2:1:rows-1
    for j = 2:1:columns-1
        avgImage(i,j) = 0;
        for k = 1:1:3
            for l = 1:1:3
                avgImage(i, j) = avgImage(i, j) + mask(k, l)*image(i+k-2, j+l-2);
            end
        end
    end
end
avgImage = avgImage - min(min(avgImage));
avgImage = (255*avgImage)/max(max(avgImage));
avgImage = uint8(avgImage);
imshow(avgImage);
fprintf('High Boost Filtered Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(avgImage, 'D:\Pattern Recognition\My Material\Matlab Codes\High_Boost_Filtered_Image.jpg');
fprintf('Image saved as High_Boost_Filtered_Image.jpg\n');