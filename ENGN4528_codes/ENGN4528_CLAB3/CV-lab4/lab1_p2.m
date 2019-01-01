% Computer Vision lab1 Task 
% Created by: Bohuai jiang, u4652552
% Created date: 5/2/2014
% Last revised: 5/3/2014

%task 1 Read a color image
image = 'photo_U5224340.JPG';
org = imread(image);

%task 2 convert to grayscale
R = org(:,:,1), G = org(:,:,2), B = org(:,:,3);
Y = 0.2126.*R + 0.7120.*G + 0.0722.*B;
figure(1), imshow(Y);
writeLoc = 'facePhotogray.png';
imwrite(Y,writeLoc,'jpg');

%task 3 add noise imnoise
noiseImageV1 = imnoise(org,'gaussian',0.1); % gaussioan variace = 0.1
noiseImageV2 = imnoise(org,'salt & pepper',0.03); % salt & pepper density = 0.03
nV1 = imnoise(Y,'gaussian',0.1);
nV2 = imnoise(Y,'salt & pepper',0.03);
%task 4 dispaly
figure(2);
%subplot(2,2,1), imshow(org),title('original Image');
%subplot(2,2,3), imshow(noiseImageV1),title('Gaussian');
%subplot(2,2,4), imshow(noiseImageV2),title('Salt and Pepper');
subplot(2,2,1), imshow(Y),title('original Image');
subplot(2,2,3), imshow(nV1),title('Gaussian');
subplot(2,2,4), imshow(nV2),title('Salt and Pepper');
              
%task 5 image filter
% G(x,y) = 1/(2pi*v) *e^(x^2+y^2)/(2v^2)
%SNR = 20*log(norm(org,'fro')/norm(org - noiseImageV1,'fro'))
hg = [0.003 0.013 0.022 0.013 0.003;
      0.013 0.059 0.097 0.059 0.013;
      0.022 0.097 0.159 0.097 0.022;
      0.013 0.059 0.097 0.059 0.013;
      0.003 0.013 0.022 0.013 0.003]
h = fspecial('average',[3 3]);
Rv1 = filter2(h,noiseImageV1(:,:,1));
Gv1 = filter2(h,noiseImageV1(:,:,2));
Bv1 = filter2(h,noiseImageV1(:,:,3));
filtImageV1 = cat(3,Rv1,Gv1,Bv1);
%figure(3), imshow(filtImageV1,[]),title('gaussian filter');
fV1 = filter2(h,nV1);
fV1g = filter2(hg,nV1);
figure(3), imshow(fV1/255),title('average filter');
figure(4), imshow(fV1g/255),title('gaussion filter  variance = 1 5x5');

SNRv1 =  20*log ( norm( double(Y), 'fro') /norm ( double(Y) -  double(nV1), 'fro' ));
SNR1 =  20*log ( norm( double(Y), 'fro') /norm ( double(Y) -  double(fV1), 'fro' ));
SNRg =  20*log ( norm( double(Y), 'fro') /norm ( double(Y) -  double(fV1g), 'fro' ));

%task 6
Rv2 = medfilt2(noiseImageV2(:,:,1));
Gv2 = medfilt2(noiseImageV2(:,:,2));
Bv2 = medfilt2(noiseImageV2(:,:,3));
filtImageV2 = cat(3,Rv2,Gv2,Bv2);
%figure(4), imshow(filtImageV2),title('median filter');
fV2 = medfilt2(nV2);
SNRv2 =  20*log ( norm( double(Y), 'fro') /norm ( double(Y) -  double(nV2), 'fro'  ));
SNR2 =  20*log ( norm( double(Y), 'fro') /norm ( double(Y) -  double(fV2), 'fro'  ));

figure(5), imshow(fV2),title('median filter');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%task 1
test = imread('text3.png');
I = rgb2gray(test);
%task 2 display 
figure(6),imhist(I);
%task 3 show
%use utso algorithm
threshold = graythresh(I);
wbI = im2bw(I,threshold);
%imshow(wbI);
% task 4 count white 1
countwhite = sum(sum(wbI==1));
% task 5 test erosion, dilation,opening. 
se = strel('disk',3);
e = imerode(wbI,se);
d = imdilate(wbI,se);
o = imopen(wbI,se);
c = imclose(wbI,se);
figure(7);
subplot(2,2,1),imshow(e),title('erosion');
subplot(2,2,2),imshow(d),title('dilation');
subplot(2,2,3),imshow(o),title('opening');
subplot(2,2,4),imshow(c),title('closing');

%task 6 Design a structural-element that can be used to extract  text rows.
%step 1 scale and dilate the object by stright line
wbI1 = imresize(wbI,0.25); % optimize caculate speed
wbI2 = imcomplement(wbI1);
I1 = imresize(I,0.25);
I2 = imcomplement(I1);
len = size(wbI1,1);
aline = strel('line',len/2,0);
nText = imdilate(wbI2,aline); %\
figure(1),imshow(nText);
% use connect components operation to find line
CC = bwconncomp(nText);
lines = CC.NumObjects;
for i = 1 : lines;
    p = 7+i;
    line = zeros(size(nText,1),size(nText,2));
    line(CC.PixelIdxList{i}) = wbI2(CC.PixelIdxList{i});
    figure(p),imshow(imcomplement(imresize(line,4)));
end
for i = 1 : lines;
    line = zeros(size(nText,1),size(nText,2));
    line(CC.PixelIdxList{i}) = I2(CC.PixelIdxList{i});
    figure(p+i),imshow(imcomplement(imresize(line/255,4)));
end
%for i = 1 : size(nText(:,1))