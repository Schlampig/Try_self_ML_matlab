function [UMultiVStruct] = UMultiV_MHKS_fun(train_binary_data,train_binary_label,C,zet,gama,uscale,M_row,M_col)

%UMultiV-MHKS���Ĵ��룬1��1��UMultiV���ԣ�������������Universum�����ĺ�����
%train_binary_data�����ڵ�ǰѵ������������
%train_binary_label�����ڵ�ǰѵ��������������Ӧ������
%gama���ɳ�����1
%C:�ɳ�����2
%zet������������ĳͷ�����
%scale������Universum������ģ������
%M_row�����󻯵�����
%M_col�����󻯵�����

[~,tempt_location] = unique(train_binary_label);
n1 = tempt_location(1);%n1��n2�ֱ��ǵ�һ��͵ڶ����������
n2 = tempt_location(2) - tempt_location(1);
train_binary_label(1:n1) = 1;
train_binary_label(n1+1:n1+n2) = -1;


universum_data = Universum_Generate(train_binary_data,train_binary_label,n1,n2,uscale);%��������Universum�ĺ���������Universum����

%��ʼ������
M = size(M_row,1);
r_q = 1/M;
p = 0.99;
total_iter = 100;
k = 1;

%�����ӽǽṹ��Result.U,Result.V��Result(k_view).V0��¼��ͬ�ӽ�M����Ҫ�õ���u,v��v0
Nu = size(universum_data,1);%Universum��������
N = size(train_binary_label,1);%��������
M = size(M_row,1);%�ӽ�����
for k_view = 1:M
    Result(k_view).U = zeros(M_row(k_view),total_iter+1);
    Result(k_view).V = zeros(M_col(k_view)+1,total_iter+1);
    Result(k_view).B = zeros(N,total_iter+1);
    Result(k_view).S1 = M_row(k_view)*eye(M_row(k_view));%S1=m*Im.m
    tempt_S2 = M_col(k_view)*eye(M_col(k_view)+1);%S2=n*In+1.n+1
    tempt_S2(M_col(k_view)+1,M_col(k_view)+1) = 0;
    Result(k_view).S2 = tempt_S2;%����S2�൱��S2~
    Result(k_view).E = zeros(N,total_iter+1);
        
    Result(k_view).U(:,k) = ones(M_row(k_view),1);
    Result(k_view).V(:,k) = ones(M_col(k_view)+1,1);
    Result(k_view).B(:,k) = ones(N,1);
end%end_for_k_view


%��ʼ����ѵ��
while (k <= total_iter)

    %һ���ӽǵ�һ�ε���
    for k_v_p = 1:M    
        Result(k_v_p).V(:,k+1) = To_get_v(Result,train_binary_data,train_binary_label,universum_data,r_q,C,zet,gama,M,N,Nu,M_row,M_col,k_v_p,k);
        Result(k_v_p).E(:,k) = To_get_e(Result,train_binary_data,train_binary_label,M_row,M_col,N,k_v_p,k);
        Result(k_v_p).B(:,k+1) = Result(k_v_p).B(:,k) + p*(Result(k_v_p).E(:,k) + abs(Result(k_v_p).E(:,k)));
        Result(k_v_p).U(:,k+1) = To_get_u(Result,train_binary_data,train_binary_label,universum_data,M,N,Nu,M_row,M_col,C,zet,gama,r_q,k_v_p,k);
    end%end_for_k_v_p
    
    stop_tag = isConver(Result,total_iter,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,M_row,M_col,k);
    
    if stop_tag == 1
        break;
    else
        k = k + 1;
    end%end_if
    
end%while

for k_v_f = 1:M
    UMultiVStruct(k_v_f).u = Result(k_v_f).U(:,k);
    UMultiVStruct(k_v_f).v = Result(k_v_f).V(:,k);
end%end_for_k_v_f


%clear all;






