D_all = dir('YaleB\*');%ָ��һ���ļ���
num_file = 72;%��ǰ�ļ������ļ�����

num_class = [];%��ʼ��
AUC = [];
AUC_row = [];
data_name = [];
for i_all = 3:num_file+2%��ȡ����Ľ��
    load(['YaleB\',D_all(i_all).name]);%����ָ���ļ����µ�i_all���ļ���.mat�Ѿ������ļ����ڣ�
    disp([num2str(i_all - 2),' ',D_all(i_all).name]);
    if isempty(data_name) == 0
        if data_name ~= D_all(i_all).name(5)%ȥ�����ݽ���ļ�ͷ��ͬ��kNN_��4���ַ�����5���ַ�ʶ��ͬ�㷨��
            AUC = [AUC;AUC_row];%ÿ��һ���㷨��ÿ��һ�������任��������a��ֵ��
            AUC_row = [];
        end
    end
    AUC_row = [AUC_row,final_mat(end-1,end)];%��ǰ���ݽ����AUC
    data_name = D_all(i_all).name(5);
    
end%end_for_i_all
AUC = [AUC;AUC_row];%���һ���㷨����������

save(['AUC_result_for_','YaleB','.mat'],'AUC');
clear all;