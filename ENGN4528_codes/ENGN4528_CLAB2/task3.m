clear all;
close all;
clc;
%Step 1: read in and rotate images
fin = imread('face_02_u6600985.jpg');
%rotate 30,60,90, rescale: 1.5,1.2,0.8
im1 = imrotate(imresize(fin,1.5),30);
im2 = imrotate(imresize(fin,1.2),60);
im3 = imrotate(imresize(fin,0.8),90);
%show images
figure;
subplot(2,2,1);
imshow(fin);
title('original image');
subplot(2,2,2);
imshow(im1);
title('rotate 30 angles and rescale 1.5');
subplot(2,2,3);
imshow(im2);
title('rotate 60 angles and rescale 1.2');
subplot(2,2,4);
imshow(im3);
title('rotate 90 angles and rescale 0.8');
%save images
imwrite(im1,'im1.jpg');
imwrite(im2,'im2.jpg');
imwrite(im3,'im3.jpg');

%Step 2: show sift images
%draw sift images
[des_ori, locs0] = my_sift(fin,'origin.key');
%showkeys(fin,locs0);
[des_im1, locs1] = my_sift(im1,'im1.key');
%showkeys(im1,locs1);
[des_im2, locs2] = my_sift(im2,'im2.key');
%showkeys(im2,locs2);
[des_im3, locs3] = my_sift(im3,'im3.key');
%showkeys(im3,locs3);

%Step 3: Match features
% Matlab inbuilt function matchFeatures work well for the this problem.
% But I still write my own codes to practice the algorithm.
%
%chosen images: im0 and im3

min_locations = [];
[a0,b0] = size(des_ori);
[a1,b1] = size(des_im3);
k = 0.6;
for i = 1:a0
    orin2im3 = repmat(des_ori(i,:),a1,1);
    %map one line in the original image to a map.
    % like (1,2,3)-->(1,2,3;1,2,3;1,2,3)
    distance = sum((orin2im3 - des_im3).^2,2);
    distance = sqrt(distance);
    sort_distance = sort(distance);
    if sort_distance(1)<k*sort_distance(2)
        min_locations = [min_locations;i,find(distance == sort_distance(1))];
    end
    
end

matchpoints1 = locs0(min_locations(1:10,1),1:2);
matchpoints2 = locs3(min_locations(1:10,2),1:2);


figure;
showMatchedFeatures(fin, im3,[matchpoints1(:,2),matchpoints1(:,1)], [matchpoints2(:,2),matchpoints2(:,1)], 'montage', 'parent',axes);



