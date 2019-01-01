function [data_clusters, cluster_stats] = my_kmeans( features, k )

% This function performs k-means clustering on data ,   
% given (k) = the number of clusters.


%  Random Initialization
nFeatures = size(features, 1);
ndims = size(features, 2); % in the L a*b*, it is 5

% in this method, we random assign each feature to a cluster
random_labels = floor(rand(nFeatures, 1) * k) + 1;
% display(random_labels);
data_clusters = random_labels;

cluster_stats = zeros(k, ndims + 1); % centre of clusters

distances = zeros(nFeatures, k);

while(1)
    
    pause(0.03);
    
    % Make a copy of cluster statistics for comparison purposes.  
    % If the difference is very small, the while loop will exit.
    last_clusters = cluster_stats;
    
    % For each cluster    
    for c = 1 : k
        
        % Find all data points assigned to this cluster
        [ind] = find(data_clusters == c);
        
        num_assigned = size(ind, 1);
        
        % some heuristic codes for exception handling. 
        if( num_assigned < 1 )
            disp('No points were assigned to this cluster, some special processing is given below');
            
            % Calculate the maximum distances from each cluster
            max_distances = max(distances);
            
            [maxx, cluster_num] = max(max_distances);
            [maxx, data_point] = max(distances(:, cluster_num));
            
            data_clusters(data_point) = cluster_num;
            
            ind = data_point;
            num_assigned = 1;
            
        end   %% end of exception handling.   
        
        % Save number of points per cluster,  plus the mean vectors.
        cluster_stats(c, 1) = num_assigned;
        
        % update centres of clusters
        if( num_assigned > 1 )
            
            summ = sum(features(ind, :));
            cluster_stats(c,2:ndims + 1) = summ / num_assigned;
            
        else
            cluster_stats(c,2:ndims + 1) = features(ind, :);
        end
        
    end
    
    % Exit criteria
    diff = sum(abs(cluster_stats(:) - last_clusters(:)));
    
    if( diff < 0.00001 )
        break;
    end
    
    % - Set each cluster center to the average of the points assigned to it.
    % - Assign each point to the nearest cluster center  
 
    % first, get distances
    distances = getDistance(cluster_stats, features, ndims);
    
    % then, get smallest distance cluster number, and update the 
    % membership assignment, i.e., update the data_clusters with current values.  
    for featureCount = 1 : 	nFeatures
            
        [~, cluster_num] = min(distances(featureCount,:));
        % cluster_num is class number which has smallest distance to this
        % feature
        data_clusters(featureCount) = cluster_num;
        
    end
    
    % Display clusters for the purpose of debugging.  
    cluster_stats
    
    %pause;
 end 
% for example:  cluster_stats =
% 
%   172.0000   -9.4800
%   177.0000    5.3816
%   192.0000   -2.1585 

% cluster_stats =
% 
%   165.0000   -9.6324
%   181.0000    5.2970
%   195.0000   -2.3686
