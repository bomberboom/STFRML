% ����x�����ǰ���֣��߽�ķ�����Ϊ0�������ǰ��
function u = x_forward_diff(u0)

    [m n] = size(u0);
    
    temp(:,1) = u0(:,1);
    temp(:, 2:n) = u0(:,1:n-1);
    
    u = u0 - temp;
    
return