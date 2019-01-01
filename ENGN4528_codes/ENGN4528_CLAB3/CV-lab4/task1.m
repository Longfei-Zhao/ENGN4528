% use for task 1: implement own k-means clustering function
clc;
clear;

% read png image, if not in 3 * 8 bits RGB, transform it
mandmImgName = 'mandm.png';
% mandmImgName = 'ANUbuilding1.jpg';
factor = 1.0; % use to set weight of x and y values
kValue = 10;
normFlag = 1;

runK_means(mandmImgName, factor, kValue, normFlag);

mandmImgName = 'peppers.png';
runK_means(mandmImgName, factor, kValue, normFlag);

factor = 10.0;
runK_means(mandmImgName, factor, kValue, normFlag);

mandmImgName = 'mandm.png';
runK_means(mandmImgName, factor, kValue, normFlag);

factor = 20.0;
runK_means(mandmImgName, factor, kValue, normFlag);

mandmImgName = 'peppers.png';
runK_means(mandmImgName, factor, kValue, normFlag);