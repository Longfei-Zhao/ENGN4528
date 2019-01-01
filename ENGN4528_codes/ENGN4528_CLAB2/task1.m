close all;
clear all;
clc;

im = imread('./images/Lenna.png');
bw = rgb2gray(im);
figure;
subplot(1,2,1);
imshow(bw);

[cols,rws] = my_corner_detector(bw,2,50000000000,11);

hold on;
plot(rws,cols,'or');
title('\bf My Harris Corners with thresh 5e10');

subplot(1,2,2);
imshow(bw);

[cols,rws] = my_corner_detector(bw,2,500000000,11);

hold on;
plot(rws,cols,'or');
title('\bf My Harris Corners with thresh 5e8');


%{
subplot(1,2,2);
imshow(bw);
hold on;
CRNs = corner(bw);
plot(CRNs(:,1),CRNs(:,2),'or');
title('\bf Matlab Harris Corners');
%}


