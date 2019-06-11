%P_3d: 4xN points
%P_2d: 3xN points
function H = homo_3d_2d(P_3d, P_2d)
    [P1, T1] = normalize_3d(P_3d);
    [P2, T2] = normalize_2d(P_2d);

    N = size(P1, 2);
    A = zeros(2*N, 12);
    %For the equation to construct the matrix A, check the chapter 7.1
    %"Computation of the Camera Matrix P" in the book 
    % "Multiple view geometry in computer vision"
    
    %each point correspondence gives us 3 equation, but the third one is a linear
    %combination of the the first two rows => there're just 2 independent
    %equations.
    for i = 1:N
        p1 = P1(:, i)';
        p2_x = P2(1,i);
        p2_y = P2(2,i);
        p2_w = P2(3,i);
        A(2*i-1,:)  = [zeros(1,4) -p2_w*p1     p2_y*p1];
        A(2*i  ,:)  = [p2_w*p1     zeros(1,4) -p2_x*p1];
    end
     
    [U,D,V] = svd(A);
    
    %take the last row corresponding to the smallest eigen vector
    %for more detail, check section in the same book
    %A5.3 Least-squares solution of homogeneous equations
    H = reshape(V(:,12), 4,3)';
    
    %concatenate the normalized homography matrix with the normalization matrix
    %1. bring points the normalized space
    %2. homogeneous transformation in the normalized space.
    %3. bring the transformed point in the target image to the pixel space
    H = inv(T2)*H*T1;
end

%P: 4xN point matrix
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

%P: 3xN point matrix
function [P_out, T] = normalize_2d(P)
    centroid = mean(P(1:2,:), 2); 
    
    %subthe all points from the centroid
    P1(1,:) = P(1,:) - centroid(1);
    P1(2,:) = P(2,:) - centroid(2);
    
    %normalize all points to the range of [0,1]
    dst = sqrt(P1(1,:).^2 + P1(2,:).^2);
    max_dst = max(dst);
    s = sqrt(2.0)/max_dst;
    
    % create the normalization matrix, which is a concatenation of scale
    % and translation matrices.
    T = [s  0 -s*centroid(1)
         0  s -s*centroid(2)
         0  0  1    ];
     
    %transform the points
    P_out = T * P;
end