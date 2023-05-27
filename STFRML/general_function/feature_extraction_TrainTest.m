% This is used to extract the cloud images features, including manifold(21) and
% GLCM(4) fetures.


function data_feature = feature_extraction(path_imgDB,channel)



%% 生成gabor滤波器
I_filter=gaborFilterBank(7,7,39,39);
% j=1
% for i=1:1:8
%    LG1(i)=I_filter(j,i);
%    j=j+1;
%    if(j>4)
%       j=1; 
%    end
% end
% j=4
% for i=1:1:8
%    LG2(i)=I_filter(j,i);
%    j=j-1;
%    if(j==0)
%       j=4; 
%    end
% end

% gabor_feature_LG1=[];
% gabor_feature_LG2=[];
subdir = dir(path_imgDB);%%列出文件夹内所有子目录，以struct形式
%info_data=readtable('.\OATH\classifications\classifications.csv');
img_num = 0;
numClass = 0;
imagesnumClass=[];
imageClass=0;
%将数据按照类别排序
%info_data=sortrows(info_data,2);
for i=1:1:length(subdir)
    if strcmp(subdir(i).name,'.') || strcmp(subdir(i).name,'..')
        continue;
    end
    imageName=subdir(i).name;
    imageClass=imageName(length(imageName)-4);
    imagesnumClass=[imagesnumClass,str2num(imageClass)];
end
lll=1:1:length(imagesnumClass);
imagesnumClass=[imagesnumClass;lll];
imagesnumClass=sortrows(imagesnumClass');%按照类排序，第二列为对应subdir中的索引号

j=0;
kind=[];
% sum13=[];
for i = 1:length(subdir)
    if strcmp(subdir(i).name,'.') || strcmp(subdir(i).name,'..')
        continue;
    end
    %numClass = numClass + 1;
    image_name = fullfile(path_imgDB,subdir(imagesnumClass(i-2,2)+2).name);%当前图像的地址
    
    %%numClass
    
    %for s = 1:length(images)
    %   if strcmp(images(s).name,'.') || strcmp(images(s).name,'..')
    %     continue;
    %end
    j = j+1;
    I = imread(image_name);
    
    %image_name = strrep(image_name,path_imgDB,'');
    data_feature(j).name = image_name;
    %         if(sum(I(:,:,1),'all')~=0  ||  sum(I(:,:,3),'all')~=0)
    %             sum13=[sum13,i];
    %         end
    %         J=histeq(I);
    %         I_new=double(J);
    %         Y = I_new(:,:,2);%选g通道
    %         [J1,PS] = mapminmax(Y,0,255);
    
%     %% 选择通道
%     if(channel=='r')
%         tongdao=1;
%         I_new=double(I(:,:,tongdao));
%     elseif(channel=='g')
%         tongdao=2;
%         I_new=double(I(:,:,tongdao));
%     elseif(channel=='b')
%         tongdao=3;
%         I_new=double(I(:,:,tongdao));
%     elseif(channel=='gray')
%         I_new=rgb2gray(I);
%     end
%     I_new=rgb2gray(I);
    I=double(I);
for ii=1:1:3
    I_new=double(I(:,:,ii));
    image_f_k1_sub(:,:,ii)=get_image_f_k(I_new);
    [EN,ENT,CON,HOM] = GLCM(I_new);
    feature_GLCM(ii,:)=[EN,ENT,CON,HOM];
    
end
    I_gabor_r=gaborFeatures(I(:,:,1),I_filter,1,1);
    I_gabor_g=gaborFeatures(I(:,:,2),I_filter,1,1);
    I_gabor_b=gaborFeatures(I(:,:,3),I_filter,1,1);
    %image_f_k1_sub(:,:,4)=get_image_f_k(double(rgb2gray(I)));%加上rgb
    %image_f_k1=[image_f_k1_sub(:,:,1),image_f_k1_sub(:,:,2),image_f_k1_sub(:,:,3)];
    %I_gabor=gaborFeatures(I_new,I_filter,1,1);
    image_f_k1=get_image_f_k(I_new);
    image_f_k1=[image_f_k1,I_gabor_r,I_gabor_g,I_gabor_b];
    image_cov_matrix = cov(image_f_k1);
    SPD(:,:,j)= SPDproject(image_cov_matrix);
    data_feature(j).feature_GLCM = [feature_GLCM(1,:),feature_GLCM(2,:),feature_GLCM(3,:)];
    data_feature(j).feature_GLCM_mean=mean(feature_GLCM);
    %image_f_k1=[image_f_k1,image_f_k1_sub(:,:,4)];
    %I_new=double(I_new);
    %[EN,ENT,CON,HOM] = GLCM(I_new);
    %data_feature(j).feature_GLCM = [EN,ENT,CON,HOM];
%     %% swt2
%     swt2_feature=extraction_swt2_1_TrainTest(I);
%     image_f_k1=[image_f_k1,swt2_feature];
%     
%     image_cov_matrix = cov(image_f_k1);
%     SPD(:,:,j)= SPDproject(image_cov_matrix);
%     L = logpsd(SPD(:,:,j));
%     feature_21 = map2IDS_vectorize(L,0);
    
%     gabor_name=['gabor_Test_',channel,'_8_6_dnspl.mat'];
%     gabor=load(gabor_name);
%     gabor_feature=gabor.gabor_Test_g_8_6_dnspl;
    
%     data_feature(j).feature_21 = feature_21';
    data_feature(j).SPD = SPD(:,:,j);
    data_feature(j).kind = imagesnumClass(i-2);
    
%     data_feature(j).gabor_manifold=map2IDS_vectorize(gabor_feature(:,:,j),0)';
    %% gabor
    
    %I_gray=rgb2gray(I);
%      I_gabor=gaborFeatures(I_new,I_filter,1,1);
%    
%     I_gabor=I_gabor*I_gabor';
%     gabor_SPD=SPDproject(I_gabor);
%     gabor_feature(:,:,j)=gabor_SPD;
%     kind=[kind,imagesnumClass(i-2)];
%     %I_gabor=[image_f_k1,I_gabor];
%     image_cov_matrix = cov(I_gabor);
%     SPD_gabor(:,:,j)= SPDproject(image_cov_matrix);
%     L = logpsd(SPD_gabor(:,:,j));
    %gabor_feature_cov = map2IDS_vectorize(L,0);
    %gabor_origin(:,:,i-2)=L;
    %[coeff,score,latent]=pca(I_gabor);
    %data_feature(j).gabor=I_gabor';
    %data_feature(j).gabor=gabor_feature_cov'; 
    disp(['Extracting  features ',image_name,' samples belong to ',num2str(imagesnumClass(i-2)),' classes.']);
    img_num=img_num+1;
end
%     gabor.gabor_origin=gabor_origin;
%     gabor.kind=kind;
% %     save('TestingImages_gabor_LG1_512','gabor_feature_LG1');
% %     save('TestingImages_gabor_LG2_512','gabor_feature_LG2');
%     name=['TestingImages_',channel,'_gabor_128'];
%     save(name,'gabor');
%   save('gabor_Test_gary_8_6.mat','gabor');
    %save('gaborpure_Train_gray_8_6','gabor_origin')
    
return