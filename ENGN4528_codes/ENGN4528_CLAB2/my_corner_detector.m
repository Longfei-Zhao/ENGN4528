function [rws,cols] = my_corner_detector(bw,sig,thre,sz)
    %Harris Corner Detector
    % parameters
    sigma = sig;
    thresh = thre;
    sze = sz;
    disp = 0;
    
    bw = double(bw); % transform the image to double
    [line,column] = size(bw); %get the size
    
    dy = [-1 0 1; -1 0 1; -1 0 1]; % derivative mask in y direction
    dx = dy'; % dx and dy have symmetrical structure

    % image derivatives
    Ix = conv2(bw,dx,'same'); % derivatives in x direction
    Iy = conv2(bw,dy,'same'); % derivatives in y direction


    %need codes here
    g = fspecial('gaussian',max(1,fix(6*sigma)),sigma); % form a gaussian kernel
    Ix2 = conv2(Ix.^2,g,'same');%Smoothed image derivatives and calculate M(1,1)
    Iy2 = conv2(Iy.^2,g,'same'); %calculate M(1,2) and M(2,1)
    Ixy = conv2(Ix.*Iy,g,'same'); %calculate M(2,2)

    Ix2 = padarray(Ix2, [(sze-1)/2, (sze-1)/2]); %make it convinient for later work
    Iy2 = padarray(Iy2, [(sze-1)/2, (sze-1)/2]); %make it convinient for later work
    Ixy = padarray(Ixy, [(sze-1)/2, (sze-1)/2]); %make it convinient for later work

    %compute the cornerness
    k = 0.04; % range of k: 0.04~0.06, 0.04 is a widely used value for Haris Detector
    
    for i = 1:line
        for j=1:column
            xx = sum(sum(Ix2(i:i+sze-1,j:j+sze-1))); %calculate sum of Ix^2
            yy = sum(sum(Iy2(i:i+sze-1,j:j+sze-1))); %calculate sum of Iy^2
            xy = sum(sum(Ixy(i:i+sze-1,j:j+sze-1))); %calculate sum of Ixy
            M = [xx,xy;xy,yy]; %represent M
            cornerness(i,j) = det(M)-k*trace(M)^2; %calculate det(M) - k*trace(M)^2, which is the cornerness
        end
    end

    max_value = ordfilt2(double(cornerness), sze^2, ones(sze)); %find local maximum points

    cornerness = (double(cornerness) == max_value) & (double(cornerness) > thresh); %find local max points and the ones bigger than thresh
    [rws, cols] = find(cornerness>0); %get result
end

