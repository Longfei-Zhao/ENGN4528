function [ distances ] = getDistance( cluster_stats, features, ndims )
% This method used to calucate distance between each feature to each
% clusters, then save these reuslts in a distances matrix, which size is
% Number of Feature * Number of Cluster.

% In order to save cacluated process, we use squared Euclidean distance.
    
    k = size(cluster_stats, 1);
    nFeatures = size(features, 1);
    distances = zeros(nFeatures, k);
    
    for featureCount = 1 : nFeatures
        for culsterCount = 1 : k    
            sumDistance = 0;
            for dimCount = 1 : ndims       
                distance = (features(featureCount, dimCount) - cluster_stats(culsterCount, dimCount + 1))^2;
                sumDistance = sumDistance + distance;           
            end
            distances(featureCount, culsterCount) = sqrt(sumDistance);
        end
    end
end

