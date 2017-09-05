function [vec_res] = BERL_test(test_all,model)


% ��������ʽ��������BEPILD_test

% ���ݲ���
w = model.w;
bpos = model.bpos;
bneg =  model.bneg;
candi_dis_pos = model.candi_dis_pos;
candi_dis_neg = model.candi_dis_neg;

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
    ypos = w'*x + bpos;
    yneg = w'*x + bneg;
    
    if yneg <= 0%��������������
        label_temp = 0;%����
    elseif ypos >= 0%���Ҳ��������Ҳ�
        label_temp = 1;%����      
    else%z���м�����
        test_dis_pos = abs(ypos);
        test_dis_neg = abs(yneg);
        p_pos = length(find(candi_dis_pos > test_dis_pos))/length(candi_dis_pos);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
        p_neg = length(find(candi_dis_neg > test_dis_neg))/length(candi_dis_neg);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
        if p_pos >= p_neg
            label_temp = 1;
        else
            label_temp = 0;
        end
    end
   
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