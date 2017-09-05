function [attr_select] = FNN_fun(train_data,dc,attr_num)

%ͨ�����پ۴�ѵ��
%train_data��ÿ��һ������
%dc������
%attr_num����������������ֻ��������
%attr_select��һ������������ά��������������������ѡȡ�Ĵ���������

train_data = train_data';
[num_s,num_d] = size(train_data);%����������num_s������ά��num_d
attr_select = zeros(num_d, attr_num);%��ʼ��

for i_d = 1:num_d
    mat_dim = abs(repmat(train_data(:,i_d),1,num_s) - repmat(train_data(:,i_d)',num_s,1));%���i_d�����ԵĲ�ֵ %ע�⣺�����Ƿ�ȡ����ֵ��
    mat_save = mat_dim;%����һ������
    %attr_r = (max(max(mat_dim)) - min(min(mat_dim)))*dc;%���԰뾶
    attr_r = mean(mean(mat_dim));%��ѡ��ƽ�����뵱�뾶
    mat_dim(find(mat_dim>=attr_r)) = 0;%С��ÿ������Բ�ܵĵ�ȡΪ1�����ڵļ������ڽ��ڵ�ȡΪ0
    mat_dim(find(mat_dim~=0)) = 1;
    vec_density = sum(mat_dim,2);%vec_density��ÿ��������i_k�����Զ�Ӧ���ܶ�������
    [~,index_1] = sort(vec_density);
    [~,index_2] = sort(index_1);%�ܶ�����
    
    
    mat_density = repmat(vec_density,1,num_s) - repmat(vec_density',num_s,1);%�����ܶȲ�ֵ����
    mat_density(find(mat_density>=0)) = 0;%�����������ܶȲ��統ǰ�����ģ���Ϊ0
    mat_density(find(mat_density~=0)) = 1;
    vec_distance = min(mat_density .* mat_save,[],2);%ѡ���ܶȱ��Լ���ĵ��о�����С���Ǹ����һ����������
    [~,index_3] = sort(vec_distance);
    [~,index_4] = sort(index_3);%��������
    
    vec_dd = abs(abs(index_2+index_4) - abs(index_2-index_4));%�ۺ���������Щ�ܶȴ���Һ��ڽ������Զ�ĵ��Ǵ����(����ֵԽ��Խ��)%����ĳ�������������һ����
    [~,index_5] = sort(vec_dd,'descend');%ֵԽ������Խ��ǰ
    [~,index_6] = sort(index_5);
    
    attr_select(i_d,:) = train_data(find(index_6<=attr_num),i_d);%ѡ����ǰά�ȵĴ�������attr_num��
    
    clear mat_dim;clear mat_save;clear attr_r;clear mat_dim;
    clear vec_density;clear mat_density;clear vec_distance;
    clear vec_dd;clear index_1;clear index_2;clear index_3;clear index_4;clear index_5;clear index_6;
end%for_i_d
