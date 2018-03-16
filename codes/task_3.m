clear all;
close all;
clc;
%step 1
fin = imread('task3.jpg');
edit = imresize(fin,[512 512]);
edit_s = rgb2gray(edit);
imwrite(edit_s,'3_1.jpg');
%step 2
noise_pic = imnoise(edit_s,'gaussian',0,30^2/255^2);
noise_pic = double(noise_pic);

figure;
subplot(1,2,1);
imshow(edit_s,[]);
title('Resized picture');
subplot(1,2,2);
imshow(noise_pic,[]);
title('Noisy picture');


%step 3
figure;
subplot(2,1,1);
h = histogram(edit_s);
title('Original Picture');
subplot(2,1,2);
h = histogram(noise_pic);
title('Noisy Picture');

%step 4
H = fspecial('gaussian',[9 9],30);
denoise = my_Gauss_filter(noise_pic,H);
figure;
subplot(1,2,1)
imshow(denoise,[]);
title('my Gauss filter');
%step 5
denoise2 = filter2(H,noise_pic);
subplot(1,2,2);
imshow(denoise2,[]);
title('Matlab Gauss Filter');


