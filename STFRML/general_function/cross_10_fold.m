%% 对标准数据集进行10-fold 交叉验证
clc
clear
close all
load E:\云图\20170926\mat文件\标准库\standard
n = 500;%%样本数
k = 10;%% 份数
iter_num = 50;%%次数
class_num = 5;%%样本类别数
for t = 1:iter_num
    indices_1 = crossvalind('Kfold',50,k);
    indices = repmat(indices_1,[5,1]);
    %% 每次的训练样本及标签
    for ii = 1:n
        feature(ii,:) = standard_21_50(t).train(ii).feature;
        kind(ii,:) = standard_21_50(t).train(ii).kind;
    end
    %% 
    for i = 1:k
        test_ind = (indices == i);
        train_ind = ~test_ind;
        train_feature = feature(train_ind,:);
        train_kind = kind(train_ind,:);
        test_feature = feature(test_ind,:);
        test_kind_true = kind(test_ind,:);
        %% 归一化
        ww = size(train_feature,1);
        AA = max(train_feature);
        BB = min(train_feature);
        max_f = repmat(AA,[ww,1]);
        min_f = repmat(BB,[ww,1]);
        train_feature = (train_feature-min_f)./(max_f-min_f);

        ee = size(test_feature,1);
        max_f = repmat(AA,[ee,1]);
        min_f = repmat(BB,[ee,1]);
        test_feature = (test_feature-min_f)./(max_f-min_f);

        test_feature(test_feature<0)=0;
        test_feature(test_feature>1)=1;
        %% SVM
        [model,class_num]= SupportVectorTrain(train_feature,train_kind,1);
        test_label = SupportVector(test_feature,model,class_num);
        [max_val,max_pos] = max(test_label');
        pre_label_SVM = max_pos';
        %% 分类结果统计计算
        ex(i,:)= 1-sum(double(logical(test_kind_true - pre_label_SVM~=0)))/size(test_kind_true,1);%准确率
        test_confusion_mat(:,:,i)=confusionmat(test_kind_true,pre_label_SVM);%%计算test的混淆矩阵
        P = repmat(sum(test_confusion_mat(:,:,i),2),[1,class_num]);
        test_confusion_rat(:,:,i)=test_confusion_mat(:,:,i)./P;%%计算各类分类准确率
        cross(i).ex = ex(i,:);
        cross(i).test_confusion_mat = test_confusion_mat(:,:,i);
        cross(i).test_confusion_rat = test_confusion_rat(:,:,i);
    end
    mean_ex(t,:) = mean(ex);
    result(t).mean_ex = mean_ex(t,:);
    result(t).cross = cross;
    mean_test_confusion_mat(:,:,t) = mean(test_confusion_mat,3);
    result(t).mean_test_confusion_mat = mean_test_confusion_mat(:,:,t);
    mean_test_confusion_rat(:,:,t) = mean(test_confusion_rat,3);
    result(t).mean_test_confusion_rat = mean_test_confusion_rat(:,:,t);
end
result(1).total_ex = mean(mean_ex);
result(1).total_confusion_mat = mean(mean_test_confusion_mat,3);
result(1).total_confusion_rat = mean(mean_test_confusion_rat,3);