clear all;
close all;
clc;

%Step 1: Read input image
path1 = './images/Peppers.png';
img1 = imread(path1);
img1 = uint8(img1/2^8);
%imshow(img1);


path2 = './images/mandm.png';
img1 = imread(path2);
imshow(img1);


title('Input Color Image');

%Step 2: Convert the image to lab channel
cform = makecform('srgb2lab');
lab = applycform(img1,cform);

%Step 3: Form 5-Dimension feature vector.
features = im2feature(lab);

%Step 4: Implement your own k-mean algorithm 

%Step 5: display the segmentation result, by calling the following
%supporting function.
[data_clusters, cluster_stats] = my_kmeans( features, 10 );
displayclusters(lab,data_clusters);

