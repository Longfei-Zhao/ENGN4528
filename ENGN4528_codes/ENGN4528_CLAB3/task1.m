clear all;
close all;
clc;

%step1: have a look at the training images
dir_name = './trainingset/';
dir_lst = dir(dir_name);
l = length(dir_lst);

top = 10;

%step2: train eigenfaces
train_matrix = [];
count = 0;
%get the train matrix
for i = 1:l
   name = dir_lst(i).name;
   if name(1)=='s'
       img = imread([dir_name,name]);
       [a,b] = size(img);
       img = reshape(img,[a*b 1]);
       img = double(img);
       train_matrix = [train_matrix,img];
       count = count+1;
   end
end

%remove DC Component
mean_face = mean(train_matrix,2);
train_matrix = train_matrix - repmat(mean_face,1,count);

%tricky: A'A and AA' have the same eigen value
%and their eigen vector can be transformed.
A = train_matrix'*train_matrix;
eigen_face = eigenfaces(A,top);

%actual eigen vectors(faces).
eigen_face = train_matrix*eigen_face;

%show eigen faces
figure;
for i = 1: top
   subplot(2,ceil(top/2),i);
   imshow(reshape(eigen_face(:,i),[a,b]),[]);
end

%step 3: read in test images
test_name = './testset/';
test_dir = dir(test_name);
ll = length(test_dir);

%get the PCA coefficients of training images
PCA_coe = zeros(count,top);
for i = 1:count
    PCA_coe(i,:) = (train_matrix(:,i)'*eigen_face)/(eigen_face'*eigen_face);
end


%get similar faces
for i = 1:ll
    name = test_dir(i).name;
    if name(1)=='s'
        test_img = imread([test_name,name]);
        figure;
        subplot(2,2,1);
        imshow(test_img,[]);
        title('original imgae');
        test_img = double(reshape(test_img,[a*b,1]));
        test_img = test_img-mean_face;
        coordinates = test_img'*eigen_face/(eigen_face'*eigen_face);
        distance = repmat(coordinates,count,1);
        distance = distance - PCA_coe;
        distance = distance.^2;
        distance = sum(distance,2);
        pos1 = find(distance == min(distance));
        pos1 = pos1(1);
        distance(pos1) = 9e+20;
        pos2 = find(distance == min(distance));
        pos2 = pos2(1);
        distance(pos2) = 9e+20;
        pos3 = find(distance == min(distance));
        pos3 = pos3(1);
        subplot(2,2,2);
        imshow(reshape(train_matrix(:,pos1)+mean_face,[a,b]),[]);
        title('The 1st similar image')
        subplot(2,2,3);
        imshow(reshape(train_matrix(:,pos2)+mean_face,[a,b]),[]);
        title('The 2nd similar image')
        subplot(2,2,4);
        imshow(reshape(train_matrix(:,pos3)+mean_face,[a,b]),[]);
        title('The 3rd similar image')
        
    end
end