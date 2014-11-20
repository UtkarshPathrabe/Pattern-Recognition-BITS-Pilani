clc;    clear all;  close all;
image = imread('cameraman.tif');
%image = rgb2gray(image);
imshow(image);
fprintf('Original Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
image  = double(image);
[rows, columns] = size(image);
for k = 1:1:8
    bitplane = zeros(rows, columns);
    for i = 1:1:rows
        for j = 1:1:columns
            if bitand(power(2,k-1), image(i,j)) == 0
                bitplane(i,j) = 0;
            else
                bitplane(i,j) = 255;
            end
        end
    end
    bitplane = uint8(bitplane);
    imshow(bitplane);
    fprintf('Bit Plane %d Image.\nProgram Paused! Press Enter to Continue...\n', k);
    pause;
    filename = ['D:\Pattern Recognition\My Material\Matlab Codes\Bit_Plane.' num2str(k) '.jpg'];
    imwrite(bitplane, filename);
    fprintf('Image saved as Bit_Plane_%d.jpg\n',k);
end