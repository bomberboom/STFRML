% 计算y方向的前向差分：边界的法向导数为0
function u = y_forward_diff(u0)

    [m n] = size(u0);
    
    temp(1,:) = u0(1,:);
    temp(2:m,:) = u0(1:m-1,:);
    
    u = u0 - temp;
    
return