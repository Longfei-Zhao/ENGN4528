clear all;
close all;
clc;

%store cooridates.
file_path = './CLAB5-Images/stereo2012a.jpg';
XYZ = [7,7,0;7,0,7;0,7,7;21,14,0;0,21,14;14,0,21;
       14,7,0;7,0,14;0,14,7;21,21,0;21,0,21;0,21,21];
im = imread(file_path);
imshow(im);
hold on;
[u,v] = ginput(12);
plot(u,v,'ro');

save data.mat XYZ u v; 

