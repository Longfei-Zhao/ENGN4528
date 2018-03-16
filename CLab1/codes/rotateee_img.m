function im_out = rotateee_img(origin_img,angle)
[h,w]=size(origin_img);  
angle=angle/180*pi;
c = cos(angle);  
s = -sin(angle);  
for i = 1:h
    for j = 1:w
        coor = [cos(angle), -sin(angle);sin(angle),cos(angle)]*[i;j];
        coor(1) = coor(1)+h;
        im_out(round(coor(1)),round(coor(2))) = origin_img(i,j);
    end
end