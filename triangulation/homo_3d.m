%P_3d: 4xN points
%P_2d: 4xN points
function H = homo_3d(P_3d_1, P_3d_2)
    [P1, T1] = normalize_3d(P_3d_1);
    [P2, T2] = normalize_3d(P_3d_2);

    N = size(P1, 2);
    A = [];

    for i = 1:N
      p1 = P1(:, i);
      p2 = P2(:, i);
      A_ = [-p1'         zeros(1,4)  zeros(1,4)   p2(1)*p1';
            zeros(1,4)  -p1'         zeros(1,4)   p2(2)*p1';
            zeros(1,4)  zeros(1,4)  -p1'          p2(3)*p1'];
      A = [A; A_];
    end
     % svd
    [U, D, V] = svd(A);

    %Select column h in V corresponding smallest value in D
    h = V(:,end);
    %Reshape h to Homography Matrix and unconditioning
    H = inv(T2)* reshape(h, 4, 4)' * T1
end
    
function [P_out, T] = normalize_3d(P)
    centroid = mean(P(1:3,:), 2); 
    
    %subthe all points from the centroid
    P1(1,:) = P(1,:) - centroid(1);
    P1(2,:) = P(2,:) - centroid(2);
    P1(3,:) = P(3,:) - centroid(3);
    
    %normalize all points to the range of [0,1]
    dst = sqrt(P1(1,:).^2 + P1(2,:).^2 + P1(3,:).^2);
    max_dst = mean(dst);
    s = sqrt(3.0)/max_dst;
    
    % create the normalization matrix, which is a concatenation of scale
    % and translation matrices.
    T = [s  0  0 -s*centroid(1)
         0  s  0 -s*centroid(2)
         0  0  s -s*centroid(3)
         0  0  0    1];
     
    %transform the points
    P_out = T * P;
end
