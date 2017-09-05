function [vec_res] = LIkNN_test(train_all,test_all,k,inf)


[r_train,~] = size(train_all);
[r_test,~] = size(test_all);
train_label = train_all(:,end)+1;%������label��1����������2��+1�Ƿ�ֹ���������hist����NaNֵ
test_label = test_all(:,end)+1;%������label��1����������2 
r_classone = length(find(test_label(:)==1));%ͳ�Ʋ�������label���ڶ�����ĸ�����label==1��
r_classtwo = r_test - r_classone;%ͳ�Ʋ�������label����������ĸ�����label==2��
vec_acc_1 = zeros(r_classone,1);%���ǲ��������������ǵ�1��(������Negative)
vec_acc_2 = zeros(r_classtwo,1);%���ǲ��������������ǵ�2�ࣨ������Positive��
count_1 = 1;%��ʼ������
count_2 = 1;

for i_test = 1:r_test
    vec_temp = sqrt(sum((repmat(test_all(i_test,1:end-1),r_train,1) - train_all(:,1:end-1)).^2,2));%f������Ҫƽ��
    [~,index1] = sort(vec_temp);
    [~,index2] = sort(index1);%����������
    K = train_all(find(index2<=k));%����ѡ��K��������Ϊ��ѡ
    w_attr_neg = var(train_all(find(train_label==1),1:end-1));%����Neg���ƽ������ֵ��ע���������Ѿ�����1
    w_attr_pos = var(train_all(find(train_label==2),1:end-1));%����Pos���ƽ������ֵ
    [I_mat] = PPIget(test_all(i_test,1:end-1),K,w_attr_neg',w_attr_pos');%����PPI������Imat(�Ѿ����մӴ�С����)����һ����Iֵ���ڶ����Ƕ�Ӧlabel
    vec_candidate = I_mat(:,2)';
    
    if k ~=1%ͳ��ÿһ��I���ڵĸ���
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
