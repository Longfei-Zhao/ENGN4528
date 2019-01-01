function [ T ] = calcPoint( u2Trans, v2Trans, uBase, vBase )
    
%     u2Trans = u2Trans(1:4);
%     v2Trans = v2Trans(1:4);
%     uBase = uBase(1:4);
%     vBase = vBase(1:4);
    
    points1 = ones(6,2);
    points2 = ones(6,2);
    
    for count = 1 : 6
    
        points1(count,1) = u2Trans(count);
        points1(count,2) = v2Trans(count);
        points2(count,1) = uBase(count);
        points2(count,2) = vBase(count);
    
    end

    xaxb = points2(:,1) .* points1(:,1);
    xayb = points2(:,1) .* points1(:,2);
    yaxb = points2(:,2) .* points1(:,1);
    yayb = points2(:,2) .* points1(:,2);

    A = zeros(size(points1, 1)*2, 9);
    A(1:2:end,3) = 1;
    A(2:2:end,6) = 1;
    A(1:2:end,1:2) = points1;
    A(2:2:end,4:5) = points1;
    A(1:2:end,7) = -xaxb;
    A(1:2:end,8) = -xayb;
    A(2:2:end,7) = -yaxb;
    A(2:2:end,8) = -yayb;
    A(1:2:end,9) = -points2(:,1);
    A(2:2:end,9) = -points2(:,2);

    [~,~,V] = svd(A);
    h = V(:,9) ./ V(9,9);
    T= reshape(h,3,3);

end



