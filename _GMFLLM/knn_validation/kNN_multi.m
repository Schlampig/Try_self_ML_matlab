function [final_res] = kNN_multi(train_all,test_all,k)


%ʹ�ý����㷨������������ݼ���
%������Χ������û�б�����ƣ����Ű졣
%k:����ֵ

%Ԥ������
sum_class = max(train_all(:,end));%�õ�������
final_res = zeros(sum_class+3,1);%��������ÿһ����ȷ��+Acc+AUC+testtime

%���Բ��裺


tic;
tempor_vec = kNN_test(train_all,test_all,k);
t2 = toc;

tempor_res = tempor_vec - test_all(:,end);%��ȷ������������Ϊ0������ȷ�����
tempor_res(find(tempor_res~=0)) = 1;%�����������Ϊ1 
final_res(sum_class + 1,1) = (size(tempor_res) - sum(tempor_res))/size(tempor_res)*100;%�����ܾ�ȷ��Acc=��ȷ����������/������������*100%

for i_statis = 1:sum_class
    tempor_class_label = find(test_all(:,end)==i_statis);%ÿһ�����������
    final_res(i_statis)  = (size(tempor_class_label,1) - sum(tempor_res(tempor_class_label)))/size(tempor_class_label,1) * 100;%��ǰ���ڷ��ྫ��
end%for_i_statis

final_res(sum_class + 2,1) = mean(final_res(1:sum_class,1));%ƽ�����ྫȷ��AUC=ÿһ����ྫȷ��/������
final_res(sum_class + 3,1) = t2;%������ʱ��


end%function