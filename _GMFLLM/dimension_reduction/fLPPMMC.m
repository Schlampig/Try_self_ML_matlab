function fLPPMMC(a,k,Rdim,dataname,dataname_index)


% ����ͳһ������н�ά��LPP��3���㷨��û������PCAȥ����Ԫ��ʹ�õ�maxarg w'X(W-uD)X'w
% k:������
% Rdim������ά��
% a:W��D֮���ƽ�����

if dataname_index == 1
    eval(['load ',dataname,'_32x32.mat']);
else
    eval(['load ',dataname,'.mat']);
end%if_index

data = fea;%ÿ��һ��������N*dά
[~,d] = size(data);

W = kNNAM(data,k);%���������
D = diag(sum(W,2));%������  
% vec_eigenvalue = diag(sum(W));%������
% D = eye(n) .*repmat(vec_eigenvalue,1,n);
WPrime = data'*W*data;%���d*d�İ�������
DPrime = data'*D*data;   

S = (WPrime - a*DPrime);
I = eye(d);


%�������󣨶��ࣩ
[TMat] = get_eigen(S,I,Rdim);%TMat��d*Rdimά    

fea = data*TMat;
gnd = gnd;

save(['LPPMMC_',dataname,num2str(Rdim),'_k',num2str(k),'_a',num2str(a),'.mat'],'fea','gnd');%�洢��ά������ݼ�

end%function