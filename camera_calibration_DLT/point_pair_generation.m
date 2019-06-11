I = imread('./calib.jpg');
imshow(I);
pnts_2d = ginput(19);
save('pnts_2d.mat', 'pnts_2d')

%define 3d points
%plane z = 0
cnt = 1;
pnts_3d = zeros(19,3);
z = 0.0;
for x = 0:2
    for y = 0:2
        pnts_3d(cnt,:) = [double(x), double(y), z];
        cnt = cnt + 1;
    end
end

z = -1.0;
for x = 0:2
    for y = 0:2
        if x > 0 && y > 0
            continue
        end
        pnts_3d(cnt,:) = [double(x), double(y), z];
        cnt = cnt + 1;
    end
end

z = -2.0;
for x = 0:2
    for y = 0:2
        if x > 0 && y > 0
            continue
        end
        pnts_3d(cnt,:) = [double(x), double(y), z];
        cnt = cnt + 1;
    end
end
save('pnts_3d.mat', 'pnts_3d')