% 计算x方向的后向差分：边界的法向导数为0，前面减后面
function u = x_backward_diff(u0)

    [m n] = size(u0);
    
    temp(:,1:n-1) = u0(:,2:n);
    temp(:,n) = u0(:, n);
    
    u = temp - u0;
    
return