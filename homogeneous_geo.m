p0 = [rand(2,1); 1];
p1 = [rand(2,1);1 ];
l = homo_line(p0, p1);
%check if p0 and p1 lie on l
disp('dot product before transformation')
disp(dot(p0, l))
disp(dot(p1, l))

%generate transformation
a = deg2rad(15);
s = 8;
t = [6 -7];
H = scale_mat(s)*rot_mat(a) * trans_mat(t(1), t(2));

%transform two points
p0_1 = H*p0;
p1_1 = H*p1;

%transform our homogeneous line. 
%while the two points are transformed the transformation H, the
%corresponding line is transformed by inv(H)
l_1 = l'/H;

%check if two transformed points still lie on the transformed line
disp('dot product after transformation')
disp(dot(p0_1, l_1))
disp(dot(p1_1, l_1))

function l = homo_line(p0, p1)
    l = cross(p0, p1);
end

function m = scale_mat(s)
    m = [s 0 0 ; 0 s 0; 0 0 1];
end

function m = trans_mat(x,y)
     m = [1 0 x; 0 1 y; 0 0 1];
end

function m = rot_mat(a)
    cs = cos(a);
    sn = sin(a);
    m = [cs -sn 0 ; sn cs 0; 0 0 1];
end
