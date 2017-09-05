function [universum_data] = Universum_Generate(train_binary_data,train_binary_label,n1,n2,scale)

%����Universum���㷨

universum_tempt_data = zeros(1,size(train_binary_data,2));
for k_i = 1:n1
    for k_j = (n1+1):(n1+n2)
        new_data = (train_binary_data(k_i,:)+train_binary_data(k_j,:))/2;%���ֵ����universum
        universum_tempt_data = [universum_tempt_data;new_data];
    end%end_for_k_j
end%end_for_k_i
Nu_tempt = size(universum_tempt_data,1);
universum_tempt_data = universum_tempt_data(2:Nu_tempt,:);

Nu = fix(scale*Nu_tempt);%��Ҫ�õ���universum����Ŀ
select_index = randperm(Nu_tempt-1);%����1-Nu_tempt����������

universum_data = zeros(1,size(train_binary_data,2));
for k_select = 1:Nu
    universum_data = [universum_data;universum_tempt_data(select_index(k_select),:)];
end%end_for_k_select
universum_data = universum_data(2:Nu+1,:);