clc;    clear all;  close all;
image = imread('moon.tif');
%image = rgb2gray(image);
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
mask = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
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
fprintf('Laplacian of Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(avgImage, 'D:\Pattern Recognition\My Material\Matlab Codes\Laplacian_Image.jpg');
fprintf('Image saved as Laplacian_Image.jpg\n');