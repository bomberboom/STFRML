
clear
addpath('D:\research\Undergraduate Graduation Project\bishe\npy-matlab-master\npy-matlab')
python_feature=readNPY("D:\research\Inception4\vgg-tensorflow-master\extracted_features_mixed_5b_OATH_inception_resnetv2.npy");

% load("D:\research\Undergraduate Graduation Project\bishe\workSpace\OATH_class2_gabor_5_8.mat");
%python_feature1=load("D:\research\Inception4\vgg-tensorflow-master\extracted_features_mixed9_OATH_inceptionv3.mat");
for i = 1:length(python_feature)
    feature1=python_feature(i,:,:,:);
    I_new=reshape(feature1,[1225,320]);
    image_cov_matrix = cov(I_new);
    SPD(:,:,i)= SPDproject(image_cov_matrix);
    disp(i)
end
save('D:\research\Undergraduate Graduation Project\bishe\workSpace\OATH_inception_resnetv2_mixed_5b.mat','SPD')
