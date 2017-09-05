function [vec_res] = PILD_test(test_all,model)

% ԭʼ�汾PILD_test

% ���ݲ���
w = model.w;
w0 = model.w0;

% Ԥ����
[row_test,col_test] = size(test_all);

r_classone = length(find(test_all(:,end)==0));%ͳ�Ʋ�������label���ڸ���ĸ�����label==0��
r_classtwo = row_test - r_classone;%ͳ�Ʋ�������label��������ĸ�����label==1��
vec_acc_1 = zeros(r_classone,1);%���ǲ��������������ǵ�1��(����Negative)
vec_acc_2 = zeros(r_classtwo,1);%���ǲ��������������ǵ�2�ࣨ����Positive��
count_1 = 1;%��ʼ������
count_2 = 1;

for i_test = 1:row_test   
    x = test_all(i_test,1:col_test-1)';
    y = w'*x + w0;
    %d = test_all(i_test,col_test);
    
    if y >= 0;%������
        label_temp = 1;
    else%�Ǹ���
        label_temp = 0;
    end%if
    
    if label_temp == test_all(i_test,end);
        answer = 1;
    else
        answer = 0;
    end%if
    
    if test_all(i_test,end) == 0;%����
        vec_acc_1(count_1) = answer;
        count_1 = count_1 + 1;
    else%����
        vec_acc_2(count_2) = answer;
        count_2 = count_2 + 1;
    end%if
        
end%for_i_test

TP = length(find(vec_acc_2(:)==1));%�����ࣨPositive������ֶԵĸ���
TN = length(find(vec_acc_1(:)==1));%�����ࣨNegative������ֶԵĸ���
FN = r_classtwo - TP;%�����ࣨPositive������ִ�ĸ���
FP = r_classone - TN;%�����ࣨNegative������ִ�ĸ���

TP_rate = TP/(TP+FN);
FP_rate = FP/(FP+TN);
TN_rate = TN/(FP+TN);
FN_rate = FN/(TP+FN);
Acc = (TP+TN)/(TP+TN+FP+FN)*100;%�ܷ��ྫȷ��
Acc2 = (TP_rate+TN_rate)*50;%����ƽ��
GM = sqrt(TP_rate*TN_rate)*100;%����ƽ��
AUC = (1+TP_rate-FP_rate)*50;%AUC����Ч��

vec_res = [TP,FP,TN,FN,Acc,Acc2,GM,AUC];