function result=cwfac(vector)
fprintf('相关系数矩阵：\n')      
std=vector*vector'/size(vector,2);
%std=cov(vector);          %求解相关系数矩阵（各个特证间的相关程度）
fprintf('特征向量（vec）及特征值（val）:\n')
[vec,val]=eig(std);            %求解特征向量和特征值
newval=diag(val);              %特征值组成对角矩阵
[y,i]=sort(newval);            %特征值从大到小排序
fprintf('特征根排序：\n')
for z=1:length(y)
    newy(z)=y(length(y)+1-z);
end         
fprintf('%g\n',newy)
rate=y/sum(y);
fprintf('\n 贡献率：\n')
newrate=newy/sum(newy)
sumrate=0;
newi=[];
for k=length(y):-1:1
    sumrate=sumrate+rate(k);
    newi(length(y)+1-k)=i(k);
    if sumrate>0.9              %设定贡献率；>0.9为11个主成分
        break;
    end
end
fprintf('主成分数：%g\n\n',length(newi));
fprintf('主成分在和：\n')
for p=1:length(newi)
    for q=1:length(y)
        result(q,p)=sqrt(newval(newi(p)))*vec(q,newi(p));
    end
end
disp(result)