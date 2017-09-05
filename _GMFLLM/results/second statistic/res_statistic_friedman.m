function res_statistic_friedman

% ���������ݼ��������ĸ�����������ָ�꣬��������Щָ���Ӧ��std��ÿ���������������ݼ������������Ƿ�������
load('Res_LPP_new.mat'); 
name_alg = {'64','100','128','200','300','512'};
num_alg = 8;
n = size(AUC_mat,1);%�����Σ�����
num_d = n/num_alg; % num_alg���㷨��num_d�ֽ�ά�����������n�����

for i = 1:num_d
    file_name = strcat('Res_rank_dim',name_alg{i},'.mat');
    % ��ȡ��ǰ�Ľ������
    AUC_now = AUC_mat((num_alg*(i-1)+1):num_alg*i,:);
    Acc_now = Acc_mat((num_alg*(i-1)+1):num_alg*i,:);
    % ��������
    AUC_score = get_score(AUC_now');
    Acc_score = get_score(Acc_now');  
    
    save(file_name,'AUC_score','Acc_score');      
end%for_i

end%function


function [Y] = get_score(X)
    % X���������ݼ������������Ƿ�������
    Y = [];
    Z = [];
    for i = 1:size(X,1)
        score = sort_friedman(X(i,:)); % ����Խ�ã�scoreԽС
        % Option 1
%         Y = [Y; [X(i,:);score]];%���ѡ����ǰһ����ָ�꣬��һ��������
        % Option 2
        Y = [Y;score];%���ѡ��ֻ��һ������
        Z = [Z;score];
        clear score;
    end%for_i
    
    % Option 1
%     m = mean(X); % ��ֵ
%     m_score = sort_friedman(m); % ƽ��ֵ����������ֵԽ������ֵԽ��
%     Y = [Y; [m;m_score;mean(Z)]]; % Y������зֱ���ָ�����X�ľ�ֵ����������ֵ�ĵ÷֣��Լ��Ե������ݼ��÷ֻ��ܺ�ľ�ֵ��scoreԽ���ʾ����Խ��    
    % Option 2
    Y = [Y;sum(Z)];
    
    Y = Y';%���������rank
end%function

