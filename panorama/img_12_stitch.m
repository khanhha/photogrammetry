I1 = imread('./1.jpg');
I2 = imread('./2.jpg');

load('./P1.mat')
load('./P2.mat')

P1  = [P1 ones(4,1)]';
P2  = [P2 ones(4,1)]';

H12 = homo2d(P1,P2);

disp('homography transform error')
error_12 = H12*P1;
error_12 = P2 - error_12 ./ error_12(3,:)

IM_12 = geokor(H12, I1, I2);
imwrite(IM_12, './IM_12.jpg')
imshow(IM_12)
P12 = ginput(4);
save('./P12.mat', 'P12');

