function D = march(I1, I2, win_size, search_range)
  h_ws = int32(floor(win_size/2));
  
  kernel = fspecial('average', win_size);
  mean_I1 = conv2(I1, kernel, 'same');
  mean_I2 = conv2(I2, kernel, 'same');
  
  D = [];
  %for each row
  for row_idx = h_ws+1:size(I1, 1)-h_ws-1
    row_idx
    %extract a band of win_size in each image
    lband = I1(row_idx-h_ws:row_idx+h_ws, :);
    rband = I2(row_idx-h_ws:row_idx+h_ws, :);
    
    %find the disparity map ffor the pair: (lband, rband)
    %for each block in the left band
    d = [];
    for col_idx = h_ws+1:size(I1, 2)-h_ws-1
      lblock = lband(:, col_idx-h_ws:col_idx+h_ws);
      
      %define search range in the other band
      k_start = max(h_ws+1,   col_idx-search_range);
      k_end   = min(size(I1, 2)-h_ws-1, col_idx+search_range);
      
      %find the best match of the left block in the right band
      max_idx = k_start;
      max_ncc = -1.0;
      for k = k_start:k_end
        rblock = rband(:, k-h_ws:k+h_ws);
        
        A = lblock - mean_I1(row_idx, col_idx);
        B = rblock - mean_I2(row_idx, k);
        corr_2 = dot(A(:),B(:)')/ sqrt(dot(A(:),A(:))*dot(B(:),B(:)));
        
        %update best match if the similarity is higher        
        if corr_2 > max_ncc
          max_ncc = corr_2;
          max_idx = k;
        end
      end
      
      #disparity = abs(x_left-x_right)
      d = [d abs(max_idx-col_idx)];
    end
    
    %accumulate another depth map row
    D = [D;d];
    
  end
end
