function fLDA(Rdim,dataname,dataname_index)


% ԭʼFisher�㷨
% Rdim������ά��

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[~,d] = size(data);%������ԭʼά��

%�����ھ��󣨶��ࣩ
Sw = zeros(d);
inclass_num = zeros(max(gnd),1);%���ÿһ��������������
mat_mean = [];%��ʼ�����ÿһ���ֵ�����ľ���һ��һ����ֵ����
for i_class = 1:max(gnd)
    data_tempor = data(find(gnd == i_class),:);
    [W_tempor,vec_mean] = SCAM(data_tempor);%���������
    Sw = Sw + W_tempor;
    mat_mean = [mat_mean;vec_mean];
    inclass_num(i_class) = inclass_num(i_class) + 1;%ͳ�Ƶ�ǰ����������
    clear W_tempor;clear data_tempor;clear vec_mean;
end%for_i_class
mat_mean = [mat_mean,inclass_num];

%�������󣨶��ࣩ
[Sb,~] = SCAMc(mat_mean);%���������

%����ֵ�ֽ⽵ά
[TMat] = get_eigen(Sb,Sw,Rdim);%TMat��d*Rdimά

fea = data*TMat;
gnd = gnd;

save(['LDA_',dataname,num2str(Rdim),'.mat'],'fea','gnd');%�洢��ά������ݼ�

end%function