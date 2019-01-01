close all;
clear all;
clc;

im_left = imread('Left.jpg');
im_right = imread('Right.jpg');
%{
figure;
subplot(1,2,1);
imshow(im_left);
title('Left Image');
subplot(1,2,2);
imshow(im_right);
title('Right Image');
hold on;
[x,y] = ginput(12);
%}
%load data
load t2.mat;
a = [1,3,5,7,9,11];
b = [2,4,6,8,10,12];
x1 = x(a);
x2 = x(b);
y1 = y(a);
y2 = y(b);
H = DLT(x2,y2,x1,y1);
disp('H = ');
disp(H);


figure;
tform = projective2d(H');
imageTrans = imwarp(im_right,tform);
subplot(1,3,1);
imshow(im_left);
title('Image Left');
subplot(1,3,2);
imshow(imageTrans,[]);
title('Transformed image');
subplot(1,3,3);
imshow(im_right);
title('Image Right');

