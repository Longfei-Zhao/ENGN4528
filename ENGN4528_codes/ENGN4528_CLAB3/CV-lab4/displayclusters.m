function displayclusters( img, clusters, factor, imageName )

    % Just take size information and then make 
    % a new display image.
    [rows, cols, ~] = size(img);

    % Reshape cluster information into image
    cluster_img = reshape( clusters, [rows cols] );

%     % Find boundaries
%     boundary_img_x = filter2( [-1 1], cluster_img, 'same' );
%     boundary_img_y = filter2( [-1 1]', cluster_img, 'same' );
%     boundary_img = (abs(boundary_img_x) + abs(boundary_img_y)) > 0;

    str = sprintf('Image %s with factor is: %d', imageName, factor);
    figure('name', str);
    subplot(1,2,1);
    imagesc(cluster_img); axis image;
    subplot(1,2,2);
    imagesc(img); axis image;

    drawnow;
    figure(gcf);

%     str = sprintf('%s boundary image', imageName);
%     figure('name', str);
%     imagesc(boundary_img); axis image; colormap(gray);

%pause;
