% ����y����ĺ����֣��߽�ķ�����Ϊ0
function u = y_backward_diff(u0)

    [m n] = size(u0);
    
    temp(1:m-1, :) = u0(2:m, :);
    temp(m, :) = u0(m, :);
    
    u = temp - u0;
    
return