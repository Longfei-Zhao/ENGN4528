function [eig_face] = eigenfaces(C,k)
%% returns top K eigenfaces

% calculate eigenvalues
[V,D] = eig(C);
%arrange the eigen values in descend order.
[eig_val,ind] = sort(diag(D),'descend');
eig_vec = V(:,ind);
% take top k vectors
if size(eig_vec,2) >= k
    eig_face = eig_vec(:,1:k);
else
    error('Not enough eigenvectors - check image matrix');
end