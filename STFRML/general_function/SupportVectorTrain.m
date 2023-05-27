function [model class_num] = SupportVectorTrain(train_data,train_label,kernaltype,class_num)
%%%%     Input:            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         train_data��ѵ����������                 %%%%%
%%%%         train_sample��ѵ���������               %%%%%
%%%%         kernaltype��svm�˺���ѡ��                %%%%%
%%%%     Output:           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         model��ѵ����svmģ��                     %%%%%


%%%%%��������
% train_data = rand(100,8);
% train_label = randi([1 8],1,100);
% test_data = rand(50,8);
% kernaltype = 4;
%%%%%

warning off
    switch kernaltype
        case 1
            kernal = 'linear';
        case 2
            %kernal = 'quadratic';
            kernal='gaussian';
        case 3
            kernal = 'rbf';
        case 4
            %kernal = 'mlp';
            kernal='polynomial';
    end
    
    
%     %�����Ŀ
%     class_num = length(unique(train_label));

    %ÿ�������ѵ��������Ŀ
    every_class_num = zeros(1,class_num);
    for i=1:size(train_data,1)
        every_class_num(train_label(i))=every_class_num(train_label(i))+1;
    end

    %ÿ��ѵ������
%     Si = cell(class_num);
    c = zeros(1,class_num);
    for i = 1:size(train_data)
        Si{c(train_label(i))*class_num+train_label(i)} = train_data(i,:);
        c(train_label(i)) = c(train_label(i))+1;
    end
    
    class = cell(class_num,ceil(length(Si)/class_num));
    class(1:length(Si)) = Si;
    class = class';
    
    for i = 1:class_num
        for j = 1:i-1
            class1 = cell2mat(class(:,i));
            class2 = cell2mat(class(:,j));
%             class1 = class1';
%             class2 = class2';
%             [fea_num num1]  = size(class1);
%             [fea_num num2]  = size(class2);
%             x = [class1 class2];
%             y = ones(1,num1+num2);
%             y(num1+1:end) = -1;
            [num1, fea_num]  = size(class1);
            [num2, fea_num]  = size(class2);
            x = [class1;class2];
            y = ones(num1+num2,1);
            y(num1+1:end) = -1;
            %model{i,j} = fitcsvm(x,y, 'KernelFunction',kernal,'OptimizeHyperparameters','all');
            model{i,j} = fitcsvm(x,y, 'KernelFunction',kernal);
        end
    end
    
return