function  feature = get_feature_6(I1)
%%=====================================================%%%%%%%%%%
%%==================  I1:待处理图像 ==================  %%
% feature：均值、标准差、光滑度、三阶矩、均匀度、信息熵6维特征========%%
I1 = I1(:,:,1);
I1 = uint8(I1);
%%灰度级数目L
L = 256;
z =0:1:255;
h = imhist(I1);
p = h/numel(I1);
%%计算均值ME
ME = z*p;
%%标准差SD
SD = ((z - ME).^2 * p)^1/2;
%%光滑度SM
delta = (SD^2) / (L-1)^2;
SM = 1 - 1/(1+delta);
%%三阶矩TM
TM = (z - ME).^3 * p;
%%均匀度UF
UF = sum(p.^2);
%%信息熵EY
x = find(p==0);
p_new = p;
p_new(x)=[];%%剔除0值
EY = -(p_new' * log2(p_new));
feature = [ME,SD,SM,TM,UF,EY];
