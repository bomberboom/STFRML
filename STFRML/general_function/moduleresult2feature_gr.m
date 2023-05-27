function GR=moduleresult2feature_gr(python_feature)
[n1,n2,n3,n4]=size(python_feature);
for i = 1:length(python_feature)
    feature1=python_feature(i,:,:,:);
    I_new=reshape(feature1,[n2*n3,n4]);
    GR(:,:,i)= I_new;
end
end