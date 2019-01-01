% clear;
% img1=imread('Left.jpg');
% 
% figure(1)
% imshow(img1);
% title('1');
% [x1 y1]=ginput(4);
% ceil(x1);
% ceil(y1);
% 
% img2=imread('Right.jpg');
% figure(2)
% imshow(img2);
% title('2');
% [x2 y2]=ginput(4);
% ceil(x2);
% ceil(y2);

A=[-x2(1) -y2(1) -1 0 0 0 x1(1)*x2(1) x1(1)*y2(1) x1(1);
    0 0 0 -x2(1) -y2(1) -1 y1(1)*x2(1) y1(1)*y2(1) y1(1);
    -x2(2) -y2(2) -1 0 0 0 x1(2)*x2(2) x1(2)*y2(2) x1(2);
    0 0 0 -x2(2) -y2(2) -1 y1(2)*x2(2) y1(2)*y2(2) y1(2);
    -x2(3) -y2(3) -1 0 0 0 x1(3)*x2(3) x1(3)*y2(3) x1(3);
    0 0 0 -x2(3) -y2(3) -1 y1(3)*x2(3) y1(3)*y2(3) y1(3);
    -x2(4) -y2(4) -1 0 0 0 x1(4)*x2(4) x1(4)*y2(4) x1(4);
    0 0 0 -x2(4) -y2(4) -1 y1(4)*x2(4) y1(4)*y2(4) y1(4);];
[u s v]=svd(A);
q=v(:,end);
q2=zeros(3,3);
q2(1,:)=q(1:3);
q2(2,:)=q(4:6);
q2(3,:)=q(7:9);
[a b o]=size(img1);

for i=1:a
    for j=1:b
        
        asd=q2*[i;j;1];
        asd(1)=asd(1)/asd(3);
        asd(2)=asd(2)/asd(3);
        asd(1) = ceil(asd(1));
        asd(2)= ceil(asd(2));
        
        if asd(1) < 1 || asd(1) > b
            img3(j,i) = 0;
             
        elseif asd(2) < 1 || asd(2) > a
            img3(j,i) = 0;
        else
            img3(j,i)= img1(asd(2),asd(1));
        end
                

    end
end

figure(3)
imshow(img3)
title('projected view using homography');