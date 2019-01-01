function H=DLT(u2Trans, v2Trans, uBase, vBase)
% Computes the homography H applying the Direct Linear Transformation
% The transformation is such that
% p = H p' , i.e.,:
% (uBase, vBase, 1)'=H*(u2Trans , v2Trans, 1)' %
% INPUTS:
% u2Trans, v2Trans - vectors with coordinates u and v of the transformed image point (p')
% uBase, vBase - vectors with coordinates u and v of the original base image point p
%
% OUTPUT
% H - a 3x3 Homography matrix %
% Zhipeng Bao 27th Apr, 2018
l = length(uBase);
% assume the length of u2Tran, v2Tran, uBase, vBase are the same, or we need
% to write some codes for anomaly detection.
A = zeros(2*l,9);
%Form the matrix A;
for i = 1:l
    x = u2Trans(i);
    y = v2Trans(i);
    xp = uBase(i);
    yp = vBase(i);
    A(2*i-1,:) =  [x,y,1,0,0,0,-xp*x,-xp*y,-xp];
    A(2*i,:) = [0,0,0,x,y,1,-yp*x,-yp*y,-yp];
end
%svd decompose
[S,D,V] = svd(A);
[w,h] = size(V);
%get the last column of V matrix which is H
H = V(:,end);
%reshape H to 3X3
H = reshape(H,[3 3])';
%Normalize H
H = H/H(3,3);

