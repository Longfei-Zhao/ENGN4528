clear all;
close all;
clc;
%step 1
fin = imread('face_02_u6600985.jpg');
fin = rgb2gray(fin);
fin = double(fin);
[a,b] = size(fin);
tmp = reshape(fin,[a*b,1]);
random_sequence = randperm(a*b);
bound = floor(a*b/20);
to1 = random_sequence(1:bound);
to0 = random_sequence(bound+1:bound*2);
tmp(to1) = 255;
tmp(to0) = 0;
tmp = reshape(tmp,[a b]);
figure;
imshow(tmp,[]);

my_denoise = my_median_filter(tmp);
inbuilt = medfilt2(tmp,[3 3]);
figure;
subplot(1,2,1);
imshow(my_denoise,[]);
title('Result of my median filter');
subplot(1,2,2);
imshow(inbuilt,[]);
title('Result of Matlab inbuilt median filter');

H = fspecial('gaussian', [9 9], 30)
mmy_denoise = my_Gauss_filter(tmp,H);
minbuilt = imfilter(tmp,H);

figure;
subplot(2,2,1);
imshow(my_denoise,[]);
title('Result of my median filter');
subplot(2,2,2);
imshow(inbuilt,[]);
title('Result of Matlab inbuilt median filter');
subplot(2,2,3);
imshow(mmy_denoise,[]);
title('Result of my gaussian filter');
subplot(2,2,4);
imshow(minbuilt,[]);
title('Result of Matlab inbuilt gaussian filter');

%Step 2
my_sobel_1 = my_sobel_filter(fin,1);
my_sobel_2 = my_sobel_filter(fin,2);
kernel = fspecial('sobel');
inbuilt_sobel = imfilter(fin,kernel);

figure;
subplot(1,3,1);
imshow(my_sobel_1,[]);
title('My sobel filter(Vertical)');
subplot(1,3,2);
imshow(my_sobel_2,[]);
title('My sobel filter(Horizon)');
subplot(1,3,3);
imshow(inbuilt_sobel,[]);
title('Matlab inbuilt sobel filter');


