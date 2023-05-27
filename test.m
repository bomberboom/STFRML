clc
clear
close all

%% choose dataset
dataset=1;

if dataset==1
    class_num=7;
    data_feature_Training=load('./extracted_feature/TrainingImages_rgb_gabor_7_7.mat');
    data_feature_Training=data_feature_Training.data_feature;
    data_feature_Testing=load('./extracted_feature/TestingImages_rgb_gabor_7_7.mat');
    data_feature_Testing=data_feature_Testing.data_feature;
    load('./result/Train&test_gabor_7_7.mat');
    load('./model/model_TrainTest.mat');
    test_label_true=zeros(length(data_feature_Testing),1);
    for countvariable=1:length(data_feature_Testing)
        test_label_true(countvariable)=data_feature_Testing(countvariable).kind+1;
    end
    %% Wt*X*W
    U=result.U;
    TL_trnX = zeros(25,25,length(data_feature_Training));
    for tmpC1 = 1:length(data_feature_Training)
        temp=data_feature_Training(tmpC1).SPD;
        TL_trnX(:,:,tmpC1) = U'*temp*U;
    end
    TL_tstX = zeros(25,25,length(data_feature_Testing));
    for tmpC1 = 1:length(data_feature_Testing)
        temp=data_feature_Testing(tmpC1).SPD;
        TL_tstX(:,:,tmpC1) = U'*temp*U;
    end
    %% logorithm
    for countvariable=1:1:length(TL_trnX)
        log_TL_trnX(:,:,countvariable)=logpsd(TL_trnX(:,:,countvariable));
    end
    for countvariable=1:1:length(TL_tstX)
        log_TL_tstX(:,:,countvariable)=logpsd(TL_tstX(:,:,countvariable));
    end
    %% vectorization
    [train_data,test_data]=spd2vector(log_TL_trnX,log_TL_tstX);

    %% normalization
    ww = size(train_data,1);
    AA = max(train_data);
    BB = min(train_data);
    max_f = repmat(AA,[ww,1]);
    min_f = repmat(BB,[ww,1]);
    train_data = (train_data-min_f)./(max_f-min_f);
    ee = size(test_data,1);
    max_f = repmat(AA,[ee,1]);
    min_f = repmat(BB,[ee,1]);
    test_data = (test_data-min_f)./(max_f-min_f);

    test_data(test_data<0)=0;
    test_data(test_data>1)=1;

    test_label = SupportVector(test_data,model,class_num);
    [max_val max_pos] = max(test_label');
    test_label_SVM = max_pos';

    %confusioin matrix
    for j = 1:class_num
        for g = 1:class_num
            confusion_num(j,g) = numel(find(test_label_true==j&test_label_SVM==g));
        end
    end
    ex= 1-sum(double(logical(test_label_true - test_label_SVM~=0)))/length(test_label_true);
    HH=repmat(sum(confusion_num(:,:),2),[1,class_num]);
    confusion_rat(:,:) = confusion_num(:,:)./HH;
    self_num=[195;33;36;44;50;29;459];% number of each kind in testing set
    confusion_num=confusion_rat.*self_num;
    sum_confusion=sum(confusion_num);
    zi_percent=diag(confusion_rat);
    zi_num=diag(confusion_num);
    precision=zi_num'./sum_confusion;
    for i=1:1:7
        f1(i)=2*zi_percent(i)*precision(i)/(zi_percent(i)+precision(i));
    end
    pre=mean(precision);
    f1=mean(f1);
    recall=mean(zi_percent);
    fprintf(['The precision is: %.2f%%\r\n'],pre*100);
    fprintf(['The f1 is: %.2f%%\r\n'],f1*100);
    fprintf(['The recall is: %.2f%%\r\n'],recall*100);
elseif dataset==2
    load('./extracted_featureOATH_class6_gabor_8_8_result.mat');
    load('./result/OATH_class6_gabor_8_8.mat');
    class_num=6;
    for i=1:10
        numTrain=0.7;
        model_name=['model_',int2str(i)];
        load(model_name);
        R=result(i).R;
        U=result(i).U;
        for countvariable=1:length(data_feature)
            feature(:,:,countvariable)=data_feature(countvariable).SPD;
            kind(countvariable)=data_feature(countvariable).kind+1;
        end
        %% Trainingset and Testingset
        ndata=length(data_feature);
        ntrain=fix(numTrain*ndata);
        trn_X=feature(:,:,R(1:ntrain));
        trn_y=kind(R(1:ntrain));
        tst_X=feature(:,:,R(ntrain+1:ndata));
        test_label_true=kind(R(ntrain+1:ndata));
        test_label_true=test_label_true';
        
        %% Wt*X*W

        TL_trnX = zeros(22,22,length(trn_X));
        for tmpC1 = 1:length(trn_X)
            TL_trnX(:,:,tmpC1) = U'*trn_X(:,:,tmpC1)*U;
        end
        TL_tstX = zeros(22,22,length(tst_X));
        for tmpC1 = 1:length(tst_X)
            TL_tstX(:,:,tmpC1) = U'*tst_X(:,:,tmpC1)*U;
        end
        %% logorithm
        for countvariable=1:1:length(TL_trnX)
            log_TL_trnX(:,:,countvariable)=logpsd(TL_trnX(:,:,countvariable));
        end
        for countvariable=1:1:length(TL_tstX)
            log_TL_tstX(:,:,countvariable)=logpsd(TL_tstX(:,:,countvariable));
        end
        %% vectorization
        [train_data,test_data]=spd2vector(log_TL_trnX,log_TL_tstX);

        %% normalization
        ww = size(train_data,1);
        AA = max(train_data);
        BB = min(train_data);
        max_f = repmat(AA,[ww,1]);
        min_f = repmat(BB,[ww,1]);
        train_data = (train_data-min_f)./(max_f-min_f);
        ee = size(test_data,1);
        max_f = repmat(AA,[ee,1]);
        min_f = repmat(BB,[ee,1]);
        test_data = (test_data-min_f)./(max_f-min_f);

        test_data(test_data<0)=0;
        test_data(test_data>1)=1;

        test_label = SupportVector(test_data,model,class_num);
        [max_val max_pos] = max(test_label');
        test_label_SVM = max_pos';

        %confusioin matrix
        for j = 1:class_num
            for g = 1:class_num
                confusion_num(j,g,i) = numel(find(test_label_true==j&test_label_SVM==g));
            end
        end
        ex(i)= 1-sum(double(logical(test_label_true - test_label_SVM~=0)))/length(test_label_true);
        HH=repmat(sum(confusion_num(:,:,i),2),[1,class_num]);
        confusion_rat(:,:,i) = confusion_num(:,:,i)./HH;
    end
        ex_mean=mean(ex);
        ex_std=std(ex);
        fprintf(['The overall accuracy over 10 runs is: %.2f±%.2f%%\r\n'],ex_mean*100,ex_std*100);
end

