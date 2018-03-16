function im_out = rotate_img(origin_img,angle)
[h,w]=size(origin_img);  
angle=angle/180*pi;
c = cos(angle);  
s = -sin(angle);  

w2=round(abs(c)*w+h*abs(s));  
h2=round(abs(c)*h+w*abs(s));  
im_out  = uint8(zeros(h2,w2));
  
  
for x=1:w2  
    for y=1:h2  
        x0 = double(x*c + y*s -0.5*w2*c-0.5*h2*s+0.5*w);  
        y0= double(y*c-x*s+0.5*w2*s-0.5*h2*c+0.5*h);               
        x0=round(x0);          
        y0=round(y0);          
        if x0>0 && y0>0&& w >= x0 && h >= y0  
            im_out(y,x) = origin_img(y0,x0);  
        end  
    end  
end  
