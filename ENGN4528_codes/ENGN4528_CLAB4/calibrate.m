function C = calibrate(im, XYZ, uv)
%% TASK 1: CALIBRATE
%
% Function to perform camera calibration
%
% Usage:   K = calibrate(image, XYZ, uv)
%
%   Where:   image - is the image of the calibration target.
%            XYZ - is a N x 3 array of  XYZ coordinates
%                  of the calibration target points. 
%            uv  - is a N x 2 array of the image coordinates
%                  of the calibration target points.
%            C   - is the 3 x 4 camera calibration matrix.
%  The variable N should be an integer greater than or equal to 6.
%
%  This function plots the uv coordinates onto the image of the calibration
%  target. 
%
%  It also projects the XYZ coordinates back into image coordinates using
%  the calibration matrix and plots these points too as 
%  a visual check on the accuracy of the calibration process.
%
%  Lines from the origin to the vanishing points in the X, Y and Z
%  directions are overlaid on the image. 
%
%  The mean squared error between the positions of the uv coordinates 
%  and the projected XYZ coordinates is also reported.
%
%  The function should also report the error in satisfying the 
%  camera calibration matrix constraints.
[len,~] = size(uv);

A = zeros(len*2,12);

for tmp = 1:len
   %get the 3D vertices and their 2D corresponding points
   X = XYZ(tmp,1);
   Y = XYZ(tmp,2);
   Z = XYZ(tmp,3);
   
   u = uv(tmp,1);
   v = uv(tmp,2);
   
   A(tmp*2-1,:) = [X,Y,Z,1,0,0,0,0,-u*X,-u*Y,-u*Z,-u];
   A(tmp*2,:) = [0,0,0,0,X,Y,Z,1,-v*X,-v*Y,-v*Z,-v];
end
[~,~,V] = svd(A);

C = V(:,end);
C = C/C(end);
C = reshape(C,[4 3]);
C = C';

imshow(im);
hold on;
plot(uv(:,1),uv(:,2),'ro');
hold on;
xyz1 = [XYZ,ones(tmp,1)]';
xy = C*xyz1;

xy(1,:) = xy(1,:)./xy(3,:);
xy(2,:) = xy(2,:)./xy(3,:);

distance = (xy(1:2,:) - uv').^2;
distance = mean(sum(distance));
disp(['Mean Square Error: ',num2str(distance)]);

plot(xy(1,:),xy(2,:),'g+');

end