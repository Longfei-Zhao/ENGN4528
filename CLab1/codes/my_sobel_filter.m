function im_out = my_sobel_filter(img,mode)
%this function denoise with a 3*3 sobel filter;
filter1 = [1,0,-1,2,0,-2,1,0,-1];
filter2 = [1,2,1,0,0,0,-1,-2,-1];
if mode == 1
    myfilter = filter1;
else
    myfilter = filter2;
end
[a,b] = size(img);
im_out = zeros(a-2,b-2);

for i = 1:a-2
    for j = 1:b-2
        img_window = img(i:i+2,j:j+2);
        img_window = reshape(img_window, [9 1]);
        im_out(i,j) = myfilter*img_window;
    end
end
