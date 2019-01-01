function [  ] = runK_means( ImgName, factor, kValue, normFlag )
% This method used to run K means algorithm with given arguments

    Img = imread(ImgName);
%     figure('name', 'Input Colour Image');
%     imshow(Img);
%     Img = uint8(Img);
    display(size(Img));

    % convert it to La*b* colour space
    cform   =  makecform('srgb2lab');
    lab = applycform(Img, cform); % get lab value space

    % build 5-dimensional feature vectors
    features = im2feature(lab, factor, normFlag);

    % perform k-means algorithm
    [k_clusters, ~] = my_kmeans(features, kValue);

    % display results
    displayclusters(Img, k_clusters, factor, ImgName);
    
    fprintf('Finish Run %s image with factor is %d\n', ImgName, factor);
    pause(0.03);
    

end

