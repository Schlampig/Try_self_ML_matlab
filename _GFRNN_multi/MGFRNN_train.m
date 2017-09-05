function [model] = MGFRNN_train(train_all)


% MGFRNN��ѵ�����̣�����ѵ������������ѵ���õ�������Ϣ
% train_all��һ��һ�����������һ���������
% m�������������ÿ����������mass
% r���̶��뾶������ѡ��İ뾶
% c��ѵ�������������
% s��ѵ����������

% ��ѵ�������������
c = length(unique(train_all(:,end))); % ѵ����������
sample_all = size(train_all,1); % ѵ����������

sample = [];
d = [];
for i_c = 1:c
    
    index_now = find(train_all(:,end) == i_c); % �ҵ����ڵ�ǰ�����������������
    sample_now = length(index_now); % ���㵱ǰ����������
    
    data_now = train_all(index_now,1:end-1); % ��õ�ǰ����������
    dist_now = get_dist(data_now,data_now,sample_now,sample_now); % ���㵱ǰ����������������󣨶Խ��߾������
    d_now = mean(mean(dist_now)); % ��ǰ����������ƽ������
    
    sample = [sample;sample_now]; % ���浱ǰ���������������Ϣ
    d = [d;d_now];
    
end%for_i_c

sample_weight = sample_all./sample; % ������Խ�࣬���ֵԽС
distance_weight = mean(d)./d; % ������ƽ������Խ�����ֵԽС
m_vec = sample_weight.*distance_weight; % ÿһ���Ȩ��

% ��ֵ
model.s = sample_all;
model.c = c;
model.r = mean(d);
model.m = m_vec;


end%function