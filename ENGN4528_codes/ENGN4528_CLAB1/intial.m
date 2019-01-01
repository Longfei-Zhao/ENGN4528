clear all;
close all;
clc;
for i = 1:3
    name = ['face_0' num2str(i) '_u6600985.jpg'];
    image = imread(name);
    images = imresize(image,[720 1024]);
    imwrite(images,name);
    %imshow(images)
end