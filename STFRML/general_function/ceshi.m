clc
clear
close all
gabor_LG1=load('.\gabor_LG1_512.mat');
gabor_LG2=load('.\gabor_LG2_512.mat');

[coeff,score,latent,tsquared,explained,mu] = pca(gabor_LG2.gabor_feature_LG2);
latent_sum=0;
total=sum(latent);
for i= 1:1:512
    latent_sum=latent_sum+latent(i);
    G(i)= latent_sum/total;
end