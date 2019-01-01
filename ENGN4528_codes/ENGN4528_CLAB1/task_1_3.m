clear all;
close all;
clc;
%3.1 e.g. select face_01
image_name = 'face_01_u6600985.jpg';
origin = imread(image_name);
edit = imresize(origin, [512 768]);
%3.2
figure;
subplot(1,2,1);
imshow(origin);
title('Orginal Image');
subplot(1,2,2);
imshow(edit);
title('Resized Image');

%3.3
r = origin(:,:,1);
g = origin(:,:,2);
b = origin(:,:,3);
figure;
imshow(r);
title('R channel grayscale image');
figure;
imshow(g);
title('G channel grayscale image');
figure;
imshow(b);
title('B channel grayscale image');
%3.4
figure;
r = double(r);
g = double(g);
b = double(b);
subplot(3,1,1);
hr = histogram(r);
title('R Channel Histogram');
subplot(3,1,2);
hg = histogram(g);
title('G Channel Histogram');
subplot(3,1,3);
hb = histogram(b);
title('B Channel Histogram');
%3.5 
r = edit(:,:,1);
g = edit(:,:,2);
b = edit(:,:,3);
figure;
subplot(1,3,1);
imshow(r);
title('R channel grayscale image');
subplot(1,3,2);
imshow(g);
title('G channel grayscale image');
subplot(1,3,3);
imshow(b);
title('B channel grayscale image');
%3.4
figure;
r = double(r);
g = double(g);
b = double(b);
subplot(3,1,1);
hr = histogram(r);
title('R Channel Histogram');
subplot(3,1,2);
hg = histogram(g);
title('G Channel Histogram');
subplot(3,1,3);
hb = histogram(b);
title('B Channel Histogram');


