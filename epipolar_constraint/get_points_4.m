I = imread('./3.jpg');
imshow(I);
[pnts_x, pnts_y] = ginput(19);
pnts = [pnts_x pnts_y]
save('pnts_3.mat', 'pnts')
