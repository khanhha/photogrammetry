pkg load image;
I1 = im2double(imread('./left.png'));
I2 = im2double(imread('./right.png'));
r = 9; %window size
s =  70; %query range
D = march(I1, I2, r, s)
D = D / max(D(:));
D = imsmooth(D, 'Gaussian');
figure();
imshow(D);
