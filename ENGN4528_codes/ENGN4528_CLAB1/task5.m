clear all;
close all;
clc;
%step 1
fin = imread('text.png');
gray_image = rgb2gray(fin);
gray_image = imresize(gray_image, [1024 1024]);
figure;
imshow(gray_image);
title('Gray image of task 5')
%step 2
bw = im2bw(gray_image,0.5);
black = length(find(bw == 0));
white = length(find(bw == 1));
whole = black + white;
disp(['White Pixel: ' num2str(white) ', Black pixel: ' num2str(black) ', Whole pixel: ' num2str(whole)]);
%step 3
figure;
%erosion
ero_10 = zeros(1,10)+1;
ero_101 = zeros(10,10)+1;
erosion_img_h_10 = imerode(bw,ero_10);
erosion_img_v_10 = imerode(bw,ero_10');
erosion_img_s_10 = imerode(bw,ero_101);

subplot(2,3,1)
imshow(erosion_img_h_10);
title('horizon erosion with index 10');
subplot(2,3,2)
imshow(erosion_img_v_10);
title('vertical erosion with index 10');
subplot(2,3,3)
imshow(erosion_img_s_10);
title('Square erosion with index 10');
ero_30 = zeros(1,30)+1;
ero_301 = zeros(30,30)+1;
erosion_img_h_30 = imerode(bw,ero_30);
erosion_img_v_30 = imerode(bw,ero_30');
erosion_img_s_30 = imerode(bw,ero_301);

subplot(2,3,4)
imshow(erosion_img_h_30);
title('horizon erosion with index 30');
subplot(2,3,5)
imshow(erosion_img_v_30);
title('vertical erosion with index 30');
subplot(2,3,6)
imshow(erosion_img_s_30);
title('Square erosion with index 30');

figure;
%dilation
dil_10 = zeros(1,10)+1;
dil_101 = zeros(10,10)+1;
dilation_img_h_10 = imdilate(bw,dil_10);
dilation_img_v_10 = imdilate(bw,dil_10');
dilation_img_s_10 = imdilate(bw,dil_101);

subplot(2,3,1)
imshow(dilation_img_h_10);
title('horizon dilation with index 10');
subplot(2,3,2)
imshow(dilation_img_v_10);
title('vertical dilation with index 10');
subplot(2,3,3)
imshow(dilation_img_s_10);
title('Square erosion with index 10');
dil_30 = zeros(1,30)+1;
dil_301 = zeros(30,30)+1;
dilation_img_h_30 = imdilate(bw,dil_30);
dilation_img_v_30 = imdilate(bw,dil_30');
dilation_img_s_30 = imdilate(bw,dil_301);

subplot(2,3,4)
imshow(dilation_img_h_30);
title('horizon dilation with index 30');
subplot(2,3,5)
imshow(dilation_img_v_30);
title('vertical dilation with index 30');
subplot(2,3,6)
imshow(dilation_img_s_30);
title('Square dilation with index 30');

figure;
%opening
open_10 = zeros(1,10)+1;
open_101 = zeros(10,10)+1;
open_img_h_10 = imopen(bw,open_10);
open_img_v_10 = imopen(bw,open_10');
open_img_s_10 = imopen(bw,open_101);

subplot(2,3,1)
imshow(open_img_h_10);
title('horizon opening with index 10');
subplot(2,3,2)
imshow(open_img_v_10);
title('vertical opening with index 10');
subplot(2,3,3)
imshow(open_img_s_10);
title('Square opening with index 10');
open_30 = zeros(1,30)+1;
open_301 = zeros(30,30)+1;
open_img_h_30 = imopen(bw,open_30);
open_img_v_30 = imopen(bw,open_30');
open_img_s_30 = imopen(bw,open_301);

subplot(2,3,4)
imshow(open_img_h_30);
title('horizon opening with index 30');
subplot(2,3,5)
imshow(open_img_v_30);
title('vertical opening with index 30');
subplot(2,3,6)
imshow(open_img_s_30);
title('Square opening with index 30');

figure;
%opening
closing_10 = zeros(1,10)+1;
closing_101 = zeros(10,10)+1;
closing_img_h_10 = imclose(bw,closing_10);
closing_img_v_10 = imclose(bw,closing_10');
closing_img_s_10 = imclose(bw,closing_101);

subplot(2,3,1)
imshow(closing_img_h_10);
title('horizon closing with index 10');
subplot(2,3,2)
imshow(closing_img_v_10);
title('vertical closing with index 10');
subplot(2,3,3)
imshow(closing_img_s_10);
title('Square closing with index 10');
closing_30 = zeros(1,30)+1;
closing_301 = zeros(30,30)+1;
closing_img_h_30 = imclose(bw,closing_30);
closing_img_v_30 = imclose(bw,closing_30');
closing_img_s_30 = imclose(bw,closing_301);

subplot(2,3,4)
imshow(closing_img_h_30);
title('horizon closing with index 30');
subplot(2,3,5)
imshow(closing_img_v_30);
title('vertical closing with index 30');
subplot(2,3,6)
imshow(closing_img_s_30);
title('Square closing with index 30');