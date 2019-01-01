clear all;
close all;
clc;
load t2.mat;
figure;
a = [1,3,5,7,9,11];
b = [2,4,6,8,10,12];

subplot(1,2,1);
imshow(im_left);
title('Left Image');
hold on;
plot(x(a),y(a),'ro');

subplot(1,2,2);
imshow(im_right);
title('Right Image');
hold on;
plot(x(b),y(b),'ro');
