function result=cwstd(vector)   %矩阵标准化：消除量纲影响

[a,b]=size(vector);
std_cwstd=std(vector);
mean_cwstd=mean(vector);
for i=1:b
    result(:,i)=(vector(:,i)-mean_cwstd(i))/std_cwstd(i);%原始代码为除以sum
end