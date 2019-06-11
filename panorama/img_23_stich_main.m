I1 = imread('./3.jpg');
I2 = imread('./3.jpg');
I3 = imread('./3.jpg');
I12 = imread('./IM_12.jpg');

load('./P3.mat')
load('./P12.mat')

P3  = [P3 ones(4,1)]';
P12 = [P12 ones(4,1)]';

H3_12 = homo2d(P3,P12);

disp('homography transform error')
error_12 = H3_12*P3;
error_12 = P12 - error_12 ./ error_12(3,:)

I_3_12 = geokor(H3_12, I3, I12);
imwrite(I_3_12 , './IM_3_12.jpg')
subplot(2,3,1); imshow(I1)
subplot(2,3,2); imshow(I2)
subplot(2,3,3); imshow(I3)
subplot(2,3,5); imshow(I_3_12)
