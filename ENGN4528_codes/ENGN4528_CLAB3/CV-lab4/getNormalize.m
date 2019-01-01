function [ Points, Transform ] = getNormalize( xValues, yValues )
% get normalize transform for given coorderinates
    
    [~, pointsSize] = size(xValues);
    
    Points = ones(3, pointsSize);
    Points(1, :) = xValues;
    Points(2, :) = yValues;

    % get the mean of x and y
    xMean = mean(xValues); % get centers
    yMean = mean(yValues);
    xDistance = xValues - xMean;
    yDistance = yValues - yMean;

    % get the scale
    xScale = mean(abs(xDistance));
    yScale = mean(abs(yDistance));

    % construct transform matrix and normalization
    Transform = [1/xScale, 0, -xMean/xScale; 0, 1/yScale, -yMean/yScale; 0, 0, 1];
    
end

