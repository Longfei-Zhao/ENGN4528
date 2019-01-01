% use for task 2: DLT based  homography estimation
clc;
clear;

imgLeft = imread('Left.jpg');
imgRight = imread('Right.jpg');

figure('name', 'Left Image and Right Image');
subplot(1,2,1);
imshow(imgLeft), title('Left Image');
subplot(1,2,2);
imshow(imgRight), title('Right Image');

hold on

% select 6 pairs points from left and right images, left iamge first
%[x, y] = ginput(12);
load t2.mat;

% get 6 left points from selected points
uBase = x(1:2:end,:)'; % odd matrix
vBase = y(1:2:end,:)'; % odd matrix

% get 6 right points from selected points
u2Trans = x(2:2:end,:)'; % even matrix
v2Trans = y(2:2:end,:)'; % even matrix

% get H
H = DLT(u2Trans, v2Trans, uBase, vBase);

disp(H);
tform = projective2d(H');
imageTransform = imwarp(imgRight, tform);

%{
% perform normalize approach
[pointBase, transformBase] = getNormalize(uBase, vBase);
[pointTrans, transformTrans] = getNormalize(u2Trans, v2Trans);

% normalize these points
normBase = transformBase*pointBase;
uBase = normBase(1,:);
vBase = normBase(2,:);

normTrans = transformTrans*pointTrans;
u2Trans = normTrans(1,:);
v2Trans = normTrans(2,:);

% then, get the 3*3 homography matrix between these two images
H = DLT(u2Trans, v2Trans, uBase, vBase);
% % get real matrix by normalized matrix
H = (transformBase\H)*transformTrans;

tform = projective2d(H');
imageNorm = imwarp(imgRight, tform);
%}
figure('name', 'Transform Right Image by H');
subplot(1,3,1), imshow(imageTransform), title('Transform Without Normalized');
%subplot(1,3,2), imshow(imageNorm), title('Transform With Normalized');
subplot(1,3,3), imshow(imgLeft), title('Transformed Left Image');
