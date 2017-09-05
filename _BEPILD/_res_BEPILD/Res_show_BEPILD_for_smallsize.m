%addpath(genpath(pwd))

% ������һ���ļ���ʽ�����ݼ���ֻ��һ��Ŀ¼�����ݼ���Ŀ�������ǹ̶��ġ�

for i_data = 1:16
    switch i_data%�������ݼ����ѡ�����ݼ�  
        case 1
            name = 'BEK1PILD_rbf_0.01';
        case 2
            name = 'BEK1PILD_rbf_0.1';
        case 3
            name = 'BEK1PILD_rbf_1';
        case 4
            name = 'BEK1PILD_rbf_10';
        case 5
            name = 'BEK1PILD_rbf_100';
        case 6
            name = 'BEK2PILD_rbf_0.01';
        case 7
            name = 'BEK2PILD_rbf_0.1';
        case 8
            name = 'BEK2PILD_rbf_1';
        case 9
            name = 'BEK2PILD_rbf_10';
        case 10
            name = 'BEK2PILD_rbf_100';
        case 11
            name = 'BEPILD_r0.01';
        case 12
            name = 'BEPILD_r0.1';
        case 13
            name = 'BEPILD_r1';
        case 14
            name = 'BEPILD_r10';
        case 15
            name = 'BEPILD_r100';            
        case 16
            name = 'BERL_5fold';             
        otherwise
            disp('You have input wrong dataset number!');%���� 
    end%end_switch_dataset_kind
    D_all = dir([name,'\*']);%ָ��һ���ļ���
    num_file = 31;%��ǰ�ļ������ļ�����

    AUC = [];
    Gmean = [];
    AUC_std = [];
    Gmean_std = [];
    for i_all = 3:num_file+2%��ȡ����Ľ��
        load([name,'\',D_all(i_all).name]);
        disp([num2str(i_all - 2),' ',D_all(i_all).name]); % ��Ļ�ϴ�ӡ�㷨����
        AUC = [AUC;final_res(end-1,8)];%��ǰ���ݽ����Gmean��AUC
        Gmean = [Gmean;final_res(end-1,7)];
        AUC_std = [AUC_std;final_res(end,8)];%����AUC/Gmean�ľ������
        Gmean_std = [Gmean_std; final_res(end,7)];
    end%end_for_i_all
    Res = [AUC,AUC_std,Gmean,Gmean_std];
    save([name,'.mat'],'Res');
    clear all;
end%for_i_data



