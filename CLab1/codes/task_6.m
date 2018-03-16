clear all;
close all;
clc;
fin = imread('text.png');
fin = rgb2gray(fin);
my_rotate = rotate_img(fin,45);
inbuilt = imrotate(fin,45);
figure;
subplot(1,2,1)
imshow(my_rotate,[]);
title('Result of my rotation function (pi/4)');
subplot(1,2,2)
imshow(inbuilt,[]);
title('Result of Matlab inbuilt rotation function (pi/4)');

my_rotate = rotate_img(fin,-45);
inbuilt = imrotate(fin,-45);
figure;
subplot(1,2,1)
imshow(my_rotate,[]);
title('Result of my rotation function (-pi/4)');
subplot(1,2,2)
imshow(inbuilt,[]);
title('Result of Matlab inbuilt rotation function (-pi/4)');
