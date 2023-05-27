
function [EN,ENT,CON,HOM] = GLCM(I)
%%EN:Energy; ENT:Entropy; CON:Contrast,Hom:Homogenity

I = I(:,:,1);
[M N] = size(I);
L = 16; %  grey levels

I=fix(double(I)/(256/L)); 
Gray=I;
P=zeros(L,L,4);   %%Grey Level Co-occurrence Matrix
for m=1:L
    for n=1:L
        for i=1:M
            for j=1:N
                if j<N && Gray(i,j)==m-1 && Gray(i,j+1)==n-1           % 0° [0,1]
                    P(m,n,1)=P(m,n,1)+1;
                end
                if i>1&&j<N && Gray(i,j)==m-1 && Gray(i-1,j+1)==n-1      % 45° [-1,1]
                    P(m,n,2)=P(m,n,2)+1;
                end
                if i>1&& Gray(i,j)==m-1 && Gray(i-1,j)==n-1                 % 90° [-1,0]
                    P(m,n,3)=P(m,n,3)+1;
                end
                if i>1&& j>1&& Gray(i,j)==m-1 && Gray(i-1,j-1)==n-1            %135°[-1,-1]
                    P(m,n,4)=P(m,n,4)+1;
                end
            end
        end
    end
end
%%Symmetry
for n = 1:4
    P(:,:,n)=P(:,:,n)+P(:,:,n)';
end
%%---------------------------------------------------------
% Normalization
%%---------------------------------------------------------
for n = 1:4
    P(:,:,n) = P(:,:,n)/sum(sum(P(:,:,n)));  
end                                           

%--------------------------------------------------------------------------
%4.对共生矩阵计算能量、熵、惯性矩、均匀性Homogenity、相关5个纹理参数
%--------------------------------------------------------------------------
ENT = zeros(1,4);
CON = ENT;
HOM = ENT;
Ux = ENT;      Uy = ENT;
deltaX= ENT;  deltaY = ENT;
C =ENT;
for n = 1:4
    EN(n) = sum(sum(P(:,:,n).^2)); %%Energy
    for i = 1:L
        for j = 1:L
            if P(i,j,n)~=0
                ENT(n) = -P(i,j,n)*log2(P(i,j,n))+ENT(n); %%Entropy
            end
            CON(n) = (i-j)^2*P(i,j,n)+CON(n);  %%Contrast
            HOM(n) = P(i,j,n)./(1+abs(i-j))+HOM(n);  %%Homogenity
%             Ux(n) = i*P(i,j,n)+Ux(n); %μx
%             Uy(n) = j*P(i,j,n)+Uy(n); %μy
        end
    end
end
% for n = 1:4
%     for i = 1:L
%         for j = 1:L
%             deltaX(n) = (i-Ux(n))^2*P(i,j,n)+deltaX(n); %σx
%             deltaY(n) = (j-Uy(n))^2*P(i,j,n)+deltaY(n); %σy
%             C(n) = i*j*P(i,j,n)+C(n);            
%         end
%     end
%     C(n) = (C(n)-Ux(n)*Uy(n))/deltaX(n)/deltaY(n);    
% end
EN = mean(EN);
ENT = mean(ENT);
CON = mean(CON);
HOM = mean(HOM);