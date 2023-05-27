% This is used to extract the cloud images features, including manifold,WLBP
% GLCM(4) and Calbo(6) fetures.
% clc;
% clear all;
% close all;
%%��׼��
maindir = 'E:\��ͼ\��׼��\';%�ļ���·��
subdir = dir(maindir);%%���ļ���·��
img_num = 0;
for i = 3:length(subdir)   
    subdirpath = fullfile(maindir,subdir(i).name,'*.jpg');
    images = dir(subdirpath);
    for s = 1:length(images)
        j = s +img_num
        image_name = fullfile(maindir,subdir(i).name,images(s).name);        
        I = imread(image_name);
        image_name = strrep(image_name,'E:\��ͼ\��׼��\','');
        zenithal_standard(j).name = image_name;
        I_new = I(:,:,1);
        
        % 2015 Liu Shuang, Ground-based cloud classification using weighted local binary patterns
%         zenithal_standard(j).RIU2_16_2 = get_WLBP(I_new,16,2);
        
        % 2015 H.-Y., Cheng Block-based cloud classification with statistical features and distribution of local texture features 
%         [feature_A,feature_B] = get_color_LBP(I_new);
%         zenithal_standard(j).feature_A = feature_A;
        
        [m, n] = size(I_new);
        I_new = double(I_new);
        feature_6 = get_feature_6(I_new);
        zenithal_standard(j).feature_6 = feature_6;
        [EN,ENT,CON,HOM] = GLCM(I_new);
        zenithal_standard(j).feature_GLCM = [EN,ENT,CON,HOM];
        %%=========��ȡ����ͼ���SPD��21ά����======%%
        image_f_k1 = get_image_f_k(I_new);%��ȡ����ͼ���f_k����
%         %%�ԻҶȹ�һ�� 20171018
%         image_f_k1_1 = image_f_k1;
%         image_f_k1_1(:,1) = (image_f_k1(:,1))/255;
%         image_cov_matrix = cov(image_f_k1_1);%��ȡ����Э����������
        image_cov_matrix = cov(image_f_k1);
        SPD(:,:,j)=SPDproject(image_cov_matrix); 
        L = logpsd(SPD(:,:,j));          
        feature_21 = map2IDS_vectorize(L,0);%%log���Ӳ�ȡ�������γ�������
        %%��׼
        zenithal_standard(j).feature_21 = feature_21';
        zenithal_standard(j).SPD = SPD(:,:,j);
    end
    img_num = img_num+length(images); %%ÿ����һ�Σ���ÿһ����Ŀ����   
end
 %%==============================��ǩ==============================%%%%
 kind = zeros(img_num,1);
 kind(1:100) = 4;%%���Ʊ�ǩ
 kind(101:200) = 1;%%��״�Ʊ�ǩ
 kind(201:300) = 5;%%��ձ�ǩ
 kind(301:400) = 3;%%��״�Ʊ�ǩ
 kind(401:end) = 2;%%��״�Ʊ�ǩ
 for i= 1:500
     zenithal_standard(i).kind = kind(i);
 end
 %%==============================��ǩ==============================%%%%
 save('E:\�ֵ�ѧϰ��ϡ���ʾ\model_1\mat\feature\zenithal_standard.mat','zenithal_standard');