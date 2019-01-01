%%
%   CLAB3 Task-1: Harris Corner Detector
%
close all;
clear all;

img = imread('lenna.png');
imshow(img);

sigma = 2; thresh = 0.01; sze = 11; disp= 0;

dy = [-1 0 1;-1 0 1; -1 0 1];
dx = dy';

Ix = conv2(bw,dx,'same');
Iy = conv2(bw,dy,'same');

g = fspecial('gaussian',max(1,fix(6*sigma)),sigma);

Ix2 = conv2(Ix.^2,g,'same');
Iy2 = conv2(Iy.^2,g,'same');
Ixy = conv2(Ix.*Iy,g,'same');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Task: Compute the Harris Cornerness R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Task: Perform non-maximum suppression and threshold here 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%   Plot the corners on the image
[rows,cols] = find(R);
imshow(uint8(bw));
hold on;
p = [cols, rows];
plot(p(:,1),p(:,2),'or');
title('Harris Corners');
