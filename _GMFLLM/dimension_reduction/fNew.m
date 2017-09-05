function fNew(a,k,Rdim,dataname,dataname_index,a_index)


% �ϳ��㷨New
% Rdim������ά��
% a:�������ĸ��Ĳ���
% k:������
% a_index = 0-7%�����㷨


if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[~,d] = size(data);


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

%���ܵ����ڹ�������A���ܵ�����������B
switch a_index %�������ݼ����ѡ�����ݼ� 
    case 1
        A = WPrime;
        B = Sb;
        algname = 'New1_';
    case 2
        A = Sw + WPrime;
        B = Sb;
        algname = 'New2_';
    case 3
        A = Sw + WPrime;
        B = FPrime;
        algname = 'New3_';
    case 4
        A = Sw;
        B = FPrime;
        algname = 'New4_';
    case 5
        A = Sw;
        B = Sb +  FPrime;
        algname = 'New5_';
    case 6
        A = WPrime;
        B = Sb +  FPrime;
        algname = 'New6_';
    case 7
        A = Sw +  WPrime;
        B = Sb +  FPrime;
        algname = 'New7_';
    otherwise
        disp('You have input wrong algorithm number!');%���� 
end%switch

%������ȡ����for MMC��
St = B - a*A;%d*d
I = eye(d);
[TMat] = get_eigen(St,I,Rdim);%����ֵ�ֽ⽵ά��TMat��d*Rdimά

% %������ȡ����for LDA��
% [TMat] = get_eigen(B,A,Rdim);%����ֵ�ֽ⽵ά��TMat��d*Rdimά


fea = data*TMat;
gnd = gnd;

save(['m',algname,dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%�洢��ά������ݼ�

end%function
