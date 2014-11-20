%%%%% Pattern Recognition (BITS F446) Assignment
%%%%% Morphological Image Processing
%%%%% Author:   Utkarsh Ashok Pathrabe - 2012A7PS034P
%%%%% Question: Download the image “image1.bmp”. Perform the hole filling and display the filled squares in figure(1). After filling, separate the two sets of different sized squares and display each sets of squares in different figure windows using figure(2) and figure(3).

%% General Housekeeping.
clc;    clear all;  close all;

%% Reading the input Image File.
image = imread('image1.bmp');

%% Create Structuring Element of dimensions (5 * 1) for eroding the Input Image.
structElement = [1; 1; 1; 1; 1];
reducedImage1 = image;
[m, n] = size(image);
p = length(structElement);
for i = ceil(p/2) : 1 : m - floor(p/2)
    for j = 1 : 1 : n
        reducedImage1(i, j) = min(min(image(i - floor(p/2) : i + floor(p/2), j)));
    end
end

%% Create Structuring Element ([1, 0, 0, 0, 1]) to find the centre of 5 * 5 Hollow Square using the output image of the previous block. 'reducedImage0' array gives the centre of 5*5 hollow squares and 'reducedImage2' is used for further processing.
structElement = [1, 0, 0, 0, 1];
reducedImage2 = reducedImage1;
reducedImage0 = zeros(size(reducedImage1));
[m, n] = size(reducedImage1);
q = length(structElement);
for i = 1 : 1 : m
    for j = ceil(q/2) : 1 : n - floor(q/2)
        if reducedImage1(i, j - floor(q/2)) == 1 && reducedImage1(i, j + floor(q/2)) == 1
            reducedImage2(i, j) = 1;
            reducedImage0(i, j) = 1;
            reducedImage2(i, j - floor(q/2)) = 0;
            reducedImage2(i, j + floor(q/2)) = 0;
        end
    end
end

%% Create Structuring Element of dimensions (7 * 1) for eroding the 'reducedImage2' Image from the previous block.
structElement = [1; 1; 1; 1; 1; 1; 1];
reducedImage1 = reducedImage2;
[m, n] = size(reducedImage2);
p = length(structElement);
for i = ceil(p/2) : 1 : m - floor(p/2)
    for j = 1 : 1 : n
        reducedImage1(i, j) = min(min(reducedImage2(i - floor(p/2) : i + floor(p/2), j)));
    end
end

%% Create Structuring Element ([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]) to find the centre of 11 * 11 Hollow Square using the output image of the previous block.
structElement = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
reducedImage2 = reducedImage1;
[m, n] = size(reducedImage1);
q = length(structElement);
for i = 1 : 1 : m
    for j = ceil(q/2) : 1 : n - floor(q/2)
        if reducedImage1(i, j - floor(q/2)) == 1 && reducedImage1(i, j + floor(q/2)) == 1
            reducedImage2(i, j) = 1;
            reducedImage2(i, j - floor(q/2)) = 0;
            reducedImage2(i, j + floor(q/2)) = 0;
        end
    end
end

%% Get the centres of all the hollow squares by adding the images containing the centres of 11*11 and 5*5 hollow squares.
holeImage = reducedImage0 + reducedImage2;

%% Get the complement of the Original Input Image
complementImage = 1 - image;

%% Create a three dimensional array for storing the consequent images that are produced when performing the Hole Filling procedure.
X = cat(3, holeImage, zeros(size(image)));

%% Create a Symmetrical Structuring Element of size 3*3 for the Hole Filling Process
structElement = ones(3);
[m, n] = size(X(:,:,1));
[p, q] = size(structElement);
k = 1;
while(~isequal(X(:,:,mod(k, 2) + 1), X(:,:,mod(k-1, 2) + 1)))
    for i = ceil(p/2) : 1 : m - floor(p/2)
        for j = ceil(q/2) : 1 : n - floor(q/2)
            X(i, j, mod(k, 2) + 1) = max(max(X(i - floor(p/2) : i + floor(p/2), j - floor(q/2) : j + floor(q/2), mod(k - 1, 2) + 1)));
            for g = i - floor(p/2) : 1 : i + floor(p/2)
                for h = j - floor(q/2) : 1 : j + floor(q/2)
                    X(g, h, mod(k, 2) + 1) = bitand(X(g, h, mod(k, 2) + 1), complementImage(g, h));
                end
            end
        end
    end
    k = mod(k + 1, 2);
end
filledImage = X(:,:,mod(k, 2) + 1) + image;

%% Display the Hole Filled Image
figure, imshow(filledImage), title('Image after performing Hole Filling:');

%% Create Structuring Element of size 11*11 containing all ones to do erosion of the Hole Filled Image, so that we get the centres of the Bigger Squares and then do dilation using the same structuring element on the resultant image to get a Image containing only the Bigger Squares.
reducedImage0 = zeros(size(filledImage));
structElement = ones(11);
[m, n] = size(filledImage);
[p, q] = size(structElement);
for i = ceil(p/2) : 1 : m - floor(p/2)
    for j = ceil(q/2) : 1 : n - floor(q/2)
        reducedImage0(i, j) = min(min(filledImage(i - floor(p/2) : i + floor(p/2), j - floor(q/2) : j + floor(q/2))));
    end
end
for i = ceil(p/2) : 1 : m - floor(p/2)
    for j = ceil(q/2) : 1 : n - floor(q/2)
        reducedImage1(i, j) = max(max(reducedImage0(i - floor(p/2) : i + floor(p/2), j - floor(q/2) : j + floor(q/2))));
    end
end

%% Get the image containing the Smaller Squares by subtracting the image containing the Bigger Squares from the Hole Filled Image.
reducedImage2 = filledImage - reducedImage1;

%% Display the image containing the Bigger and Smaller Squares.
figure, imshow(reducedImage1), title('Set of Bigger Squares:');
figure, imshow(reducedImage2), title('Set of Smaller Squares:');