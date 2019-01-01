close all;
clear all;
clc;

load data;

file_path = './CLAB5-Images/stereo2012a.jpg';
img = imread(file_path);

C = calibrate(img,XYZ,[u,v]);
disp(C);
[K, R, t] = vgg_KR_from_P(C);
disp('K = ');
disp(K);
disp('R = ');
disp(R);
disp('t = ');
disp(t);
%calculate focal
alpha = K(1,1);
gama = K(1,2);
thelta = acot(gama/-alpha);
fx = abs(alpha);
fy = abs(K(2,2)*sin(thelta));
f = sqrt(fx^2+fy^2);
disp(['fx: ',num2str(fx)]);
disp(['fy: ',num2str(fy)]);
disp(['focal: ',num2str(f)]);



