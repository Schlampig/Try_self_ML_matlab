D_all = dir('PIE\*');%ָ��һ���ļ���
num_file = 28;%��ǰ�ļ������ļ�����

num_class = [];%��ʼ��
Acc = [];
AUC = [];
Acc_std = [];
AUC_std = [];
for i_all = 3:num_file+2%��ȡ����Ľ��
    load(['PIE\',D_all(i_all).name]);%����ָ���ļ����µ�i_all���ļ���.mat�Ѿ������ļ����ڣ�
    disp([num2str(i_all - 2),' ',D_all(i_all).name]);
    num_class = [num_class;1];
    Acc = [Acc;final_mat(end-2,end)];%��ǰ���ݽ����Acc
    AUC = [AUC;final_mat(end-1,end)];%��ǰ���ݽ����AUC
    Acc_std = [Acc_std; std(final_mat(end-2,1:end-1))];%ʮ��Acc�ľ������
    AUC_std = [AUC_std; std(final_mat(end-1,1:end-1))];%ʮ��AUC�ľ������
end%end_for_i_all
Res = [AUC,Acc,AUC_std,Acc_std];

save(['Res_show_PIE.mat'],'Res');
clear all;