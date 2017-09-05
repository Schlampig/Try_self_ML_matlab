function [vec_res] = EkNN_test(train_all_new,test_all,k)


[r_test,~] = size(test_all);
train_label = train_all_new(:,end-1)+1;%������label��1����������2��+1�Ƿ�ֹ���������hist����NaNֵ
test_label = test_all(:,end)+1;%������label��1����������2 
r_classone = length(find(test_label(:)==1));%ͳ�Ʋ�������label���ڶ�����ĸ�����label==1��
r_classtwo = r_test - r_classone;%ͳ�Ʋ�������label����������ĸ�����label==2��
vec_acc_1 = zeros(r_classone,1);%���ǲ��������������ǵ�1��(������Negative)
vec_acc_2 = zeros(r_classtwo,1);%���ǲ��������������ǵ�2�ࣨ������Positive��
count_1 = 1;%��ʼ������
count_2 = 1;


for i_test = 1:r_test
    
    temp = repmat(test_all(i_test,1:end-1),size(train_all_new,1),1) - train_all_new(:,1:end-2);
    vec_temp = sqrt(sum(temp.^2,2)) - train_all_new(:,end);
    
    [~,index1] = sort(vec_temp);
    [~,index2] = sort(index1);%����������
    vec_candidate = (train_label(find(index2<=k)))';%��ѡ����������һ������ת��Ϊ����������Ϊhist����������ʱlabel��rank���б�ʾ��䶯
    if k ~=1%����k����ͳ��ÿһ����ڸ���
        [j_rank,j_label] = hist(vec_candidate, unique(vec_candidate));%ͳ�Ƴ�������ֵ
        y = [j_label',j_rank']; 
        z = sortrows(y,-2);%���ճ��ִ������������򣬴����ٵĳ��ף�����Ӹ���,��ͶƱ�������ж�Ϊ��ǰ�ֿ������ڵ���
    else
        z(1,1) = vec_candidate;%����ڲ�������ɢ�ֲ���ͶƱ
    end%if
    
    if z(1,1) == test_label(i_test); 
        answer = 1;
    else
        answer = 0;
    end%if
    
    if test_label(i_test) == 1;
        vec_acc_1(count_1) = answer;
        count_1 = count_1 + 1;
    else
        vec_acc_2(count_2) = answer;
        count_2 = count_2 + 1;
    end%if
    
    clear j_rank;clear j_label;clear vec_candidate;
    clear index1;clear index2;
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