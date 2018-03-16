function im_out = my_median_filter(noisy_img)
%this function denoise with a 3*3 median filter;
[a,b] = size(noisy_img);
im_out = zeros(a-2,b-2);

for i = 1:a-2
    for j = 1:b-2
        img_window = noisy_img(i:i+2,j:j+2);
        img_window = sort(reshape(img_window, [9 1]));
        im_out(i,j) = img_window(5);
    end
end

