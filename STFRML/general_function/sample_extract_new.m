function [train_feature,train_kind,test_feature,test_kind,train_index,test_index]=sample_extract_new(feature,kind,x)
 %%train_feature:ѵ������������     train_kind��ѵ��������� %%
 % test_feature����������������      test_kind������������� %%
 %feature���ܵ���������������        kind���ܵ��������%%
         %x:���������г�ȡ������ѵ�������ı���%%
 %%���������Ŀ������������Ŀ
       all = [feature,kind];
       [m,n] = size(all);
       [all_new,index] = sortrows(all,n);%%��������������Ľ����֮ǰһ������
       feature_new = all_new(:,1:end-1);
        kind_new = all_new(:,end);
        
       class_num=length(unique(kind_new));%%�����Ŀ
       every_class_num = zeros(1,class_num);
       for i=1:size(feature_new,1)%ÿһ�������ж��ٸ�����
           every_class_num(kind_new(i))=every_class_num(kind_new(i))+1;
       end
%        num_label_class1=length(find(kind==1));
%        num_label_class2=length(find(kind==2));
%        num_label_class3=length(find(kind==3));
%        num_label_class4=length(find(kind==4));
%        num_label_class5=length(find(kind==5));

%%�Ա���x�Ը��������������ȡ����ÿ���ȡ���������ѵ�����������µ���Ϊ��������
         w=round(x.*every_class_num);%round:��������Ϊ����
%        w1=round(x*num_label_class1);
%        w2=round(x*num_label_class2);
%        w3=round(x*num_label_class3);
%        w4=round(x*num_label_class4);
%        w5=round(x*num_label_class5);
        
        
%         a=[0, every_class_num(1),sum(every_class_num(1:2)),sum(every_class_num(1:3)),sum(every_class_num(1:4))];      

%          b1=a(1)+randperm(every_class_num(1),w(1));
%          b2=a(2)+randperm(every_class_num(2),w(2));
%          b3=a(3)+randperm(every_class_num(3),w(3));
%          b4=a(4)+randperm(every_class_num(4),w(4));
%          b5=a(5)+randperm(every_class_num(5),w(5));
%          b=[b1,b2,b3,b4,b5];
       a=zeros(1,class_num+1);
       b=zeros(max(w),class_num);
       for i=1:class_num
           a(i+1) =sum(every_class_num(1:i));
           b(1:w(i),i)=(a(i)+randperm(every_class_num(i),w(i)))';%���ɳ�ȡ�����ݱ��
       end
       c=b(b~=0);
       
       train_feature=feature_new(c,:);
       train_kind=kind_new(c,:);
       
       test_feature=feature_new;
       test_feature(c,:)=[];%�����н�ѵ����������������[]Ϊ�ռ�����ʣ�µľ�ֻ�в��Լ�
       
       test_kind=kind_new;
       test_kind(c,:)=[];   
       
       train_index = index(c);
       test_index = index;
       test_index(c) = [];

       