%P1: 3xN points
%P2: 3xN points
function H = homo2d(P1, P2)
    [P1, T1] = normalize(P1);
    [P2, T2] = normalize(P2);

    N = size(P1, 2);
    A = zeros(2*N, 9);
    %For the equation to construct the matrix A, check the chapter 4.1
    %"The Direct Linear Transformation (DLT) algorithm" in the book 
    % "Multiple view geometry in computer vision"
    
    %each point correspondence gives us 3 equation, but the third one is a linear
    %combination of the the first two rows => there're just 2 independent
    %equations.
    for i = 1:N
        p1 = P1(:, i)';
        p2_x = P2(1,i);
        p2_y = P2(2,i);
        p2_w = P2(3,i);
        A(2*i-1,:) = [zeros(1,3) -p2_w*p1     p2_y*p1];
        A(2*i  ,:)   = [p2_w*p1     zeros(1,3) -p2_x*p1];
    end
     
    [U,D,V] = svd(A);
    
    %take the last row corresponding to the smallest eigen vector
    %for more detail, check section in the same book
    %A5.3 Least-squares solution of homogeneous equations
    H = reshape(V(:,9), 3,3)';
    
    %concatenate the normalized homography matrix with the normalization matrix
    %1. bring points the normalized space
    %2. homogeneous transformation in the normalized space.
    %3. bring the transformed point in the target image to the pixel space
    H = inv(T2)*H*T1;
end

%P: 3xN point matrix
function [P_out, T] = normalize(P)
    centroid = mean(P(1:2,:), 2); 
    
    %subthe all points from the centroid
    P1(1,:) = P(1,:) - centroid(1);
    P1(2,:) = P(2,:) - centroid(2);
    
    %normalize all points to the range of [0,1]
    dst = sqrt(P1(1,:).^2 + P1(2,:).^2);
    max_dst = max(dst);
    s = 1.0/max_dst;
    
    % create the normalization matrix, which is a concatenation of scale
    % and translation matrices.
    T = [s  0 -s*centroid(1)
         0  s -s*centroid(2)
         0  0  1    ];
     
    %transform the points
    P_out = T * P;
end