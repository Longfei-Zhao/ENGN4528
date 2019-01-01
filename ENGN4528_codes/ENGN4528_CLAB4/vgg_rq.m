function [ R, Q ] = vgg_rq( H )
[q,r] = qr(inv(H));
Q = q';
R = r^-1;
end

