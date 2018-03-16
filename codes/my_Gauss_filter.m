function im_out = my_Gauss_filter(noisy_image, my_9x9_gausskernel)
%gauss_kernel should be prepared already
[a,b] = size(noisy_image);
im_out = zeros(a-8,b-8);
gauss = reshape(my_9x9_gausskernel,[1,81]);

for i = 1:a-8
    for j = 1:b-8
        img_window = noisy_image(i:i+8,j:j+8);
        img_window = reshape(img_window,[81,1]);
        im_out(i,j) = gauss*img_window;
    end
end

      
