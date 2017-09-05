function fFLPP(k,Rdim,dataname,dataname_index)


% �Ǳ�׼FLPP�㷨��û������PCAȥ����Ԫ��ʹ�õ�maxarg w'XLX'w/w'XFX'w�������޼ල
% k:������
% Rdim������ά��

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[num,d] = size(data);

%�����ڹ�������Ww��������˹����L
options = [];
options.NeighborMode = 'Supervised';
options.gnd = gnd;
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 1;
Ww = constructW(data,options);%���������
Dw = diag(sum(Ww,2));%������  
L = Dw - Ww;
LPrime = data'*L*data;%���d*d�İ�������
  

%������������Wb��������˹����F  
Wb = [];%��ʼ������������ 
for i_sample = 1:num
    gnd_tempor = gnd;
    gnd_tempor(find(gnd == gnd(i_sample))) = 0;
    gnd_tempor(find(gnd ~= gnd(i_sample))) = 1;%�͵�ǰ������ͬ����������Ŷ�Ϊ1
    gnd_tempor(i_sample) = 1;%��ǰ��������Ϊ1
    gnd_tempor(find(gnd_tempor == 0)) = 2;%�͵�ǰ����ͬ����������Ŷ�Ϊ2
    
    options2 = [];
    options2.NeighborMode = 'Supervised';
    options2.gnd = gnd_tempor;%ʹ���µ�����
    options2.NeighborMode = 'KNN';
    options2.k = k;
    options2.WeightMode = 'HeatKernel';
    options2.t = 1;
    W_tempor = constructW(data,options2);%����ʱ��������
    vec_now = W_tempor(i_sample,:);
     
    Wb = [Wb;vec_now];%��¼��i_class������ѵ��������ֵ
    clear gnd_tempor;clear W_tempor;clear vec_now;
end%for_i_class
Db = diag(sum(Wb,2));%������    
F = Db - Wb;
FPrime = data'*F*data;        

%������������
[TMat] = get_eigen(FPrime,LPrime,Rdim);%TMat��d*Rdimά    

fea = data*TMat;
gnd = gnd;

save(['FLPP_',dataname,num2str(Rdim),'_k',num2str(k),'.mat'],'fea','gnd');%�洢��ά������ݼ�


end%function