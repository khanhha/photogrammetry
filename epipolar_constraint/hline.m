% Example call of the HLINE-function
% ----------------------------------
% function test                    
% %        ====
% l = [-1 1 50]';                          % Line equation in implicit form
% f = imread('image.jpg');                                   % Read image f
% figure, imshow(f), hold on                     % Show image in new window 
% hline(l);                                    % Draw red line l in image f

function  h = hline(l, varargin)                       
%        ==================
	if abs(l(1)) < abs(l(2))                                  % More horizontal
		xlim = get(get(gcf, 'CurrentAxes'), 'Xlim');  
		x1 = cross(l, [1; 0; -xlim(1)]);
		x2 = cross(l, [1; 0; -xlim(2)]);
	else                                                        % More vertical
		ylim = get(get(gcf, 'CurrentAxes'), 'Ylim');
		x1 = cross(l, [0; 1; -ylim(1)]);
		x2 = cross(l, [0; 1; -ylim(2)]);
	end
	x1 = x1 / x1(3);
	x2 = x2 / x2(3);
	h = line([x1(1) x2(1)], [x1(2) x2(2)], varargin{:});
end