%%
%   CLAB3 Task-3
%
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Step-1: read in an input colour image. ( If it is not a 24-bit RGB image, 
%   then you need to convert it to a 24-bit RGB image.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = imread('lenna.png');
imshow(img), title('Input colour image');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Step-2: convert the image to the La*b* Colour Space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cform = makecform('srgb2lab');
lab = applycform(img, cform);

%L_Image = lab(:, :, 1); % this is the L channel image.
%A_Image = lab(:, :, 2); % this is the a channel image.
%B_Image = lab(:, :, 3); % this is the b channel image.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Step-3: Form 5-dimensional feature vector:
%   Use the following provided supporting function im2feature(). 
%   Read and understand the function; if you find bugs or typos in the 
%   provided code, if any, please fix them.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [features] = im2feature(img)

[rows, cols, ncolors] = size(img);
npixels = rows * cols;

%   Each feature vector consists of [L,a,b,x,y]
[x,y] = meshgrid(1:cols,1:rows);

features = img;
factor = 1.0 ;  % In your experiment, you may also change the value of 'factor' 
                % to e.g. 10, or 0.1, to see whether there is any change to your final results.
features(:,:,4) = factor * x;
features(:,:,5) = factor * y;
features = reshape( features, [npixels 5] );

%   Normalize the features
for i=1:size(features,2)
    % Zero mean
    features(:,i) = features(:,i) - mean(features(:,i));
    % Normalize
    features(:,i) = features(:,i) / norm(features(:,i));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Task: Implement your own k-means algorithm by completing the following 
%   supporting function (a matlab file "my_kmeans.m" is provided on Wattle):
%   This function performs k-means clustering on data , given (nc) = the number of clusters
%
%   function [data_clusters, cluster_stats] = my_kmeans( data, nc )
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Step-4: display the segmentation result, by calling the following supporting function:
%
%   function displayclusters(img, clusters )
%