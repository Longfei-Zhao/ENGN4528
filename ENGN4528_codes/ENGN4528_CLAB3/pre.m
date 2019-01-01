clear all;
close all;
clc;


%step1: have a look at the training images
dir_name = './testset/';
dir_lst = dir(dir_name);
crop_dir = './testset/'
l = length(dir_lst);

%step2: train eigenfaces
train_matrix = [];
for i = 1:l
   name = dir_lst(i).name;
   if name(1)=='t'
       img = imread([dir_name,name]);
       img = imresize(img,[231,195]);
       imwrite(img,[crop_dir,name]);
   end
end