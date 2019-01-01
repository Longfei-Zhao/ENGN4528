clear all;
close all;
clc;

im = imread('./images/Lenna.png');
bw = im2bw(im);
imshow(bw);
hold on;

CRNs = corner(bw);
plot(CRNs(:,1),CRNs(:,2),'or');

