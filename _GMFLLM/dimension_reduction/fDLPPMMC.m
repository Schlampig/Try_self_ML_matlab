function fDLPPMMC(a,k,Rdim,dataname,dataname_index)


% ����ͳһ������н�ά��DLPP/MMC�㷨��û������PCAȥ����Ԫ��ʹ�õ�maxarg w'(YFY' - aXWX)w
% Rdim������ά��
% a:XWX��YFY'֮��Ĳ���
% k:������

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[~,d] = size(data);

%��������������W���мල��
options = [];
options.NeighborMode = 'Supervised';
options.gnd = gnd;
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
W = constructW(data,options);%���������
D = diag(sum(W,2));
WPrime = data'*(D-W)*data;%���d*d�İ�������

%�����������F
sum_class = max(gnd);
cdata = [];%��Ÿ�����ľ�ֵ����
for i_class = 1:sum_class
    data_class = data(find(gnd == i_class),:);%ѡ����i_class������ѵ���������������
    cdata = [cdata;mean(data_class)];%��¼��i_class������ѵ��������ֵ
end%for_i_class

options2 = [];
options2.NeighborMode = 'KNN';
options2.k = k;
options2.WeightMode = 'HeatKernel';
options2.t = 1;
F = constructW(cdata,options2);%�����������
E = diag(sum(F,2));
FPrime = cdata'*(E-F)*cdata;     

St = FPrime - a*WPrime;%d*d
I = eye(d);

%����ֵ�ֽ⽵ά
[TMat] = get_eigen(St,I,Rdim);%TMat��d*Rdimά

fea = data*TMat;
gnd = gnd;

save(['DLPPMMC_',dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%�洢��ά������ݼ�

end%function
