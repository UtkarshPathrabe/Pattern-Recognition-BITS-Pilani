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
Threshold = input('Type the initial threshold value:\n'); 
Tolerance = input('Type the Tolerance value:\n'); 
[rows, columns] = size(image);
NewThreshold = sum(sum(image))/(rows * columns); 
OldThreshold = Threshold;
count3 = 0;
while abs(OldThreshold - NewThreshold) > Tolerance
    count3 = count3 + 1;
    count1 = 1;
    count2 = 1;
    sum1 = 0;
    sum2 = 0;
    for i = 1:rows
        for j = 1:columns
            if image(i,j) > Threshold
                count1 = count1 + 1;
                sum1 = sum1 + image(i,j);
            else
                count2 = count2+1;
                sum2 = sum2 + image(i,j);
            end
        end
    end
    avg1 = sum1/count1;
    avg2 = sum2/count2;
    NewThreshold = 0.5*(avg1+avg2);
    OldThreshold = Threshold;
    Threshold = NewThreshold;
end
fprintf('Iterated the procedure for %d times for the tolerance level of %d.\n', count3, Tolerance);
for i = 1:rows
    for j = 1:columns
        if image(i,j) > Threshold
            image(i,j) = 255;
        else
            image(i,j) = 0;
        end
    end
end
image = uint8(image);
imshow(image);
fprintf('Global Thresholded Image.\nProgram Paused! Press Enter to Continue...\n');
pause;
imwrite(image, 'D:\Pattern Recognition\My Material\Matlab Codes\Global_Thresholded_Image.jpg');
fprintf('Image saved as Global_Thresholded_Image.jpg\n');