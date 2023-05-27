%[fid,vector,v1,result]=cwprint('data.txt',145,55)

function [fid,vector,v1,result]=cwprint(filename,a,b)
fid=fopen(filename,'r')
vector=fscanf(fid,'%g',[a,b]);
fprintf('标准化结果如下：\n')
v1=cwstd(vector)
result=cwfac(v1);   
%result