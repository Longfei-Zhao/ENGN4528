function [ features ] = im2feature( img, factor, normFlag )
% This method used to extract features from given image, becuase this used
% to image segement, then each pixel should have a feature

    [rows, cols, ~] = size(img);
    npixels = rows * cols; % number of pixels

    % Each feature vector consists of [ L,a,b,x,y]
    [x,y] = meshgrid(1:cols, 1:rows); % get x, y values
    
    features = img;
    
    % add two dimensions for x, y coordinates in vectors
    features(:, :, 4) =  factor * x;
    features(:, :, 5) =  factor * y;
    
    features = reshape(features, [npixels 5]);
    features = double(features);
    
    if normFlag > 0
        
        disp('Normalize Features');
        pause(0.03);
        
        % Normalize the features, which benefits to get two vector distance
        for i = 1 : size(features,2)

%             MaxValue = max(features(:, i));
%             MinValue = min(features(:, i));
%             gap = MaxValue - MinValue;
%             features(:, i) = (features(:, i) - MinValue) / (gap + eps);

            % Zero mean
            features(:,i) = features(:,i) - mean(features(:,i));
            % Normalize
            features(:,i) = features(:,i) / norm(features(:,i));

        end
        
    end

end

