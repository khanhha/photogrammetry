%  Example call of the GEOKOR function
%  -------------------------------------------
% function test                    
%          ====
% f = imread('image1.ppm');                          % Read example images
% g = imread('image2.ppm');
% H = [1 0.1 10; 0 1 20; 0 0 1];   % Example for projective Transformation
% i = geokor(H, f, g);      % Transform image f using H and combine with g
% figure; imshow(i);                                   % Show image mosaic


function i = geokor (H, f, g)
%        ====================
	[h1 w1 d] = size(f); f = double(f);                     % Image dimensions
	[h2 w2 d] = size(g); g = double(g);

     % Transformation of image corners to determine the resulting size
	cp = norm2(H * [1 1 w1 w1; 1 h1 1 h1; 1 1 1 1]);
	Xpr = min([cp(1, :) 0]) : max([cp(1, :) w2]);              % min x : max x
	Ypr = min([cp(2, :) 0]) : max([cp(2, :) h2]);              % min y : max y
	[Xp, Yp] = ndgrid(Xpr, Ypr);
	[wp hp] = size(Xp);                                           % = size(Yp)
	X = norm2(H \ [Xp(:) Yp(:) ones(wp*hp, 1)]');    % Indirect transformation
	
	xI = reshape(X(1, :), wp, hp)';           % Resampling of intensity values 
	yI = reshape(X(2, :), wp, hp)';
	f2 = zeros(hp, wp); i = f2;
	for k = 1 : d
		f2(1:h1, 1:w1, k) = f(:, :, k);
		i(:, :, k) = interp2(f2(:, :, k), xI, yI);    % bilinear interpolation           
	end
                      % Copy the original image g in the rectified image f
	off = -round([min([cp(1, :) 0]) min([cp(2, :) 0])]);
	Index = find(sum(g, 3) > 9); 
	for k = 1 : d
    		iPart = i(1+off(2) : h2+off(2), 1+off(1) : w2+off(1), k);
    		fChannel = g(:, :, k);
    		iPart(Index) = fChannel(Index);
    		i(1+off(2) : h2+off(2), 1+off(1) : w2+off(1), k) = iPart;
	end
	i(~isfinite(i)) = 0;
	i = uint8(i);

end

function n = norm2(x)
	for i = 1 : 3
		n(i,:) = x(i,:) ./ x(3,:);	
	end

end
