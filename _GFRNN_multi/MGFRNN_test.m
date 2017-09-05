function [vec_res] = MGFRNN_test(test_all, train_all, model)


% MGFRNN�Ĳ��Թ��̣���Ҫѵ�����ݲ���
% test_all��һ��һ�����������һ���������
% m�������������ÿ����������mass
% r���̶��뾶������ѡ��İ뾶
% c��ѵ�������������
% s��ѵ����������

% ���ݲ���
s = model.s;
c = model.c;
r = model.r;
vec_mass = model.m;

% Ԥ����
test_num = size(test_all,1); % ������������
label_train = train_all(:,end); % ѵ����������� 
label_test = test_all(:,end); % �������������
label_pre = [];

for i_test = 1:test_num
    vec_dist = get_dist(train_all(:,1:end-1),test_all(i_test,1:end-1),s,1);
    candi_index = find(vec_dist <= r); % �ڰ뾶r���ڵ�ѵ���������ɺ�ѡ����index
    mat_mass = [vec_dist(candi_index),label_train(candi_index)]; % ��һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
    pre_now = get_gravity(mat_mass,vec_mass,c); % ����ѵ��ʱ�õ������ݺ������Ԥ�⵱ǰ���������������
    label_pre = [label_pre;pre_now];
end%for_i_test

cmp_label = label_pre - label_test;
cmp_label(find(cmp_label~=0)) = 1; % ��Ԥ��������������Ϊ1����ȷ��Ϊ0

res_temp = [];
for i_c = 1:c
    cmp_now = cmp_label(find(label_test ==  i_c));
    AA_now = 1 - sum(cmp_now)/length(cmp_now); % ��i_c�����Ԥ����ȷ��
    res_temp = [res_temp;AA_now];
end%for_i_c
Acc = (1 - sum(cmp_label)/test_num)*100; % �ܷ��ྫȷ��
AA = mean(res_temp)*100; % ����ƽ����ȷ��
GM = prod(res_temp).^(1/c)*100;%����ƽ����ȷ��
All = 0.5*(Acc+AA); % Acc��AA��ֵ

vec_res = [-1,-1,-1,-1,Acc,AA,GM,All];

end%function


