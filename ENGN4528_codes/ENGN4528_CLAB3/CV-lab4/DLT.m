function [ H ] = DLT( u2Trans, v2Trans, uBase, vBase )

% Computes the homography H applying the Direct Linear Transformation 
% The transformation is such that 
% p = H p' , i.e.,:  
% (uBase, vBase, 1)'=H*(u2Trans , v2Trans, 1)' 
% 
% INPUTS: 
% u2Trans, v2Trans - vectors with coordinates u and v of the transformed image point (p') 
% uBase, vBase - vectors with coordinates u and v of the original base image point p  
% 
% OUTPUT 
% H - a 3x3 Homography matrix  
% 
% Sai Ma, 04/23/2015

    % check two vectors size, if they are not match, return false
    [~, SizeU2Trans] = size(u2Trans);
    [~, SizeV2Trans] = size(v2Trans);
    [~, SizeUBase] = size(uBase);
    [~, SizeVBase] = size(vBase);
    
    if SizeU2Trans ~= SizeV2Trans || SizeUBase ~= SizeVBase
        error('x and y coordinater vectors must have same size');
    elseif SizeU2Trans ~= SizeUBase
        error('points from two images must have same number');
    end
    
    pointNums = SizeU2Trans; % get number of points
    
    % then, consturct matrix A
    A = ones(2*pointNums, 9);
    
    for count = 1 : pointNums
        
        xPrime = uBase(:, count);
        yPrime = vBase(:, count);
        
        x = u2Trans(:, count);
        y = v2Trans(:, count);

        A(2*count - 1,1:9) = [x, y, ones(1, 1), zeros(1, 3), -xPrime*x, -xPrime*y, -xPrime];
        A(2*count, 1:9) = [zeros(1, 3), x, y, ones(1, 1), -yPrime*x, -yPrime*y, -yPrime];
        
    end
    
    % The right singular vectors of A are the eigenvectors of A'*A
    [~, ~, V] = svd(A);
    H = V(:, end);
    H = reshape(H, 3, 3)'; % change it shape to make used to test solution
    
    leftDown = H(3, 3)';
    H = H/leftDown; % make the left down equals to 1

end

