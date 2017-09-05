function [vec_res] = CCDDN_test(train_all,test_all,k)

[r_test,c_test] = size(test_all);
train_one = train_all(find(train_all(:,end)==0),:);%�ҳ�ѵ�����ݼ��еĶ��������һ���¾���label==0��
train_two = train_all(find(train_all(:,end)==1),:);%�ҳ�ѵ�����ݼ��е����������һ���¾���label==1��
 
r_classone = length(find(test_all(:,end)==0));%ͳ�Ʋ�������label���ڶ�����ĸ�����label==0��
r_classtwo = r_test - r_classone;%ͳ�Ʋ�������label����������ĸ�����label==1��
vec_acc_1 = zeros(r_classone,1);%���ǲ��������������ǵ�1��(������Negative)
vec_acc_2 = zeros(r_classtwo,1);%���ǲ��������������ǵ�2�ࣨ������Positive��
count_1 = 1;%��ʼ������
count_2 = 1;


for i_test = 1:r_test
    
    train_1 = [test_all(i_test,1:(end-1));train_one(:,1:(end-1))];
    train_2 = [test_all(i_test,1:(end-1));train_two(:,1:(end-1))];
    
    p_1 = Cal_p(train_1,k);
    p_2 = Cal_p(train_2,k);
  
    if p_1 > p_2%���ڶ�����
        label_temp = 0;
    else
        label_temp = 1;
    end%end_if
    
    if label_temp == test_all(i_test,end);
        answer = 1;
    else
        answer = 0;
    end%if
    
    if test_all(i_test,end) == 0;
        vec_acc_1(count_1) = answer;
        count_1 = count_1 + 1;
    else
        vec_acc_2(count_2) = answer;
        count_2 = count_2 + 1;
    end%if
        
    clear vec_eligible;clear vec_temp;clear index_temp;clear vote_value;clear label_temp;
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
GM = sqrt((TP/(TP+FN))*(TN/(TN+FP)))*100;%����ƽ��
AUC = (1+TP_rate-FP_rate)*50;%AUC

vec_res = [TP,FP,TN,FN,Acc,Acc2,GM,AUC];

end