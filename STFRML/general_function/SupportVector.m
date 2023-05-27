function test_label = SupportVector(test_data,model,class_num)
%%%%   Input:       %%%%%%%%%%%%%%%%
%%%%    test_data�������������� %%%%
%%%%    class_num���������     %%%%
%%%%    model��ѵ���õ�svmģ��  %%%%

    [num_test fea_num] = size(test_data);
    test_label = zeros(num_test,class_num);
    for k = 1:num_test
        num = zeros(1,class_num);
        for i = 1:class_num
            for j = 1:i-1
                [G,score] = predict(model{i,j},test_data(k,:));%��i��͵�j�����������һ�ࡣG=1��Ϊi�ࣻG=-1��Ϊj��
                if G == 1
                    num(i) = num(i)+1;
                end
                if G == -1
                    num(j) = num(j)+1;
                end
            end
        end
        test_label(k,:) = num;
    end

return