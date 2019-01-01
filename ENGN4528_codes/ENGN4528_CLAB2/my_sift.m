function [descriptors, locs] = my_sift(image,keys)
% Summarize and reduce some parts of the given sift function.
% The reason is that my mac cannot do the sift and my windows does not
% support win32.
% Thus I use a ubuntu server to finish sift and this function is used to
% get the sift points.
%
% image: XXX.jpg, original image.
% keys: the XXX.key file got from the sift.
[rows, cols] = size(image); 

% Open tmp.key and check its header.
g = fopen(keys, 'r');
if g == -1
    error('Could not open file tmp.key.');
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
    error('Invalid keypoint file beginning.');
end
num = header(1);
len = header(2);
if len ~= 128
    error('Keypoint descriptor length invalid (should be 128).');
end

% Creates the two output matrices (use known size for efficiency)
locs = double(zeros(num, 4));
descriptors = double(zeros(num, 128));

% Parse tmp.key
for i = 1:num
    [vector, count] = fscanf(g, '%f %f %f %f', [1 4]); %row col scale ori
    if count ~= 4
        error('Invalid keypoint file format');
    end
    locs(i, :) = vector(1, :);
    
    [descrip, count] = fscanf(g, '%d', [1 len]);
    if (count ~= 128)
        error('Invalid keypoint file value.');
    end
    % Normalize each input vector to unit length
    descrip = descrip / sqrt(sum(descrip.^2));
    descriptors(i, :) = descrip(1, :);
end
fclose(g);


