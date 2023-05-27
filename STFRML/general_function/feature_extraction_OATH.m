% This is used to extract the cloud images features, including manifold(21) and
% GLCM(4) fetures.


function data_feature = feature_extraction(path_imgDB)

subdir = dir(path_imgDB);%%列出文件夹内所有子目录，以struct形式
info_data=readtable('.\OATH\classifications\classifications.csv');
img_num = 0;
numClass = 0;

%numClass
imagesnumClass=[];
imagesnumClass=info_data(:,2);
numClass=size(unique(imagesnumClass),1);

%% 数据排序
% %将数据按照类别排序,两种类别切换有三个地方要改
% 
% %info_data=sortrows(info_data,1);%class2
% info_data=sortrows(info_data,2);%class6


% lll=1:1:length(imagesnumClass);
% imagesnumClass=[imagesnumClass;lll];
% imagesnumClass=sortrows(imagesnumClass');%按照类排序，第二列为对应subdir中的索引号
info_data=table2struct(info_data);
j=0;
gabor_bank=gaborFilterBank(8,8,39,39);
% sum13=[];
for i = 1:length(subdir)
    if strcmp(subdir(i).name,'.') || strcmp(subdir(i).name,'..')
        continue;
    end
    %numClass = numClass + 1;
    image_name = fullfile(path_imgDB,subdir(info_data(i-2).picNum+2).name);%当前图像的地址
    
    %%numClass
    
    %for s = 1:length(images)
     %   if strcmp(images(s).name,'.') || strcmp(images(s).name,'..')
       %     continue;
        %end
        j = j+1;
        I = imread(image_name);
        
%         I_shaped=zeros(146,146);
%         I_shaped=double(I(56:201,56:201,2));
% %         J=histeq(I_shaped);
        I_new=double(I(:,:,2));
        %image_name = strrep(image_name,path_imgDB,'');
        data_feature(j).name = image_name;
%         if(sum(I(:,:,1),'all')~=0  ||  sum(I(:,:,3),'all')~=0)
%             sum13=[sum13,i];
%         end
       
%         I_new=double(J);
%         Y = I(:,:,2);%选g通道
%         [J1,PS] = mapminmax(Y,0,255);
        
        
        
        gabor_feature=gaborFeatures(I_new,gabor_bank,1,1);

        [EN,ENT,CON,HOM] = GLCM(I_new);
        data_feature(j).feature_GLCM = [EN,ENT,CON,HOM];
        %swt2_feature=extraction_swt2_1_OATH(I_new);
        
        image_f_k1 = get_image_f_k(I_new);
        image_f_k1 = gabor_feature;
        %image_f_k1 = [image_f_k1,gabor_feature];
        %image_f_k1=[image_f_k1,swt2_feature];
        %image_f_k1=swt2_feature;%
        image_cov_matrix = cov(image_f_k1);
        SPD(:,:,j)= SPDproject(image_cov_matrix);
        L = logpsd(SPD(:,:,j));
        feature_21 = map2IDS_vectorize(L,0);
        
        data_feature(j).feature_21 = feature_21';
        data_feature(j).SPD = SPD(:,:,j);
        %data_feature(j).kind = info_data(i-2).class6;
        data_feature(j).kind = info_data(i-2).class2;
        disp(['Extracting  features ',image_name,' samples belong to ',num2str(info_data(i-2).class2),' classes.']);
        img_num=img_num+1;
    end
    





return