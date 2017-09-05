function fLPP(k,Rdim,dataname,dataname_index)


% ����ͳһ������н�ά��ԭʼLPP�㷨��û������PCAȥ����Ԫ��ʹ�õ�maxarg w'X(W-uD)X'w
% k:������
% Rdim������ά��

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[~,d] = size(data);

options = [];
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;

W = constructW(data,options);%���������
D = diag(sum(W,2));%������  
WPrime = data'*W*data;%���d*d�İ�������
DPrime = data'*D*data;   


%�������󣨶��ࣩ
[TMat] = get_eigen(WPrime,DPrime,Rdim);%TMat��d*Rdimά    

fea = data*TMat;
gnd = gnd;

save(['LPP_',dataname,num2str(Rdim),'_k',num2str(k),'.mat'],'fea','gnd');%�洢��ά������ݼ�

end%function