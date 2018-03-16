clear all;
close all;
clc;
input = 'colorwheel.jpg';
origin = imread(input);
edit = rgb2hsv(origin);
figure;
subplot(1,2,1);
imshow(origin)
title('origin iamge');
subplot(1,2,2);
imshow(edit(:,:,1));
title('H Channel Image');

%position_a = [327,425,528,613,644,627,534,432,320,247,226,253];
%position_b = [211,190,216,284,395,501,579,611,575,499,402,292];

position_a = [340 534 738 906 968 934 750 548 326 182 140 194];
position_b = [170 128 180 316 538 750 906 970 898 746 552 332];
values = zeros(1,12);
figure;
for x = 1:12
    subplot(3,4,x);
    a = position_a(x);
    b = position_b(x);
    imshow(origin(a-20:a+20,b-20:b+20,:));
    values(x) = mean(mean(edit(a-20:a+20,b-20:b+20,1)));
    title(['Area' num2str(x)])
end


figure;
imshow(edit(:,:,1));
for y = 1:12
   content = ['Average Hue: ' num2str(values(y))];
   text(position_a(y),position_b(y),content ,'horiz','center','color','r');
end

