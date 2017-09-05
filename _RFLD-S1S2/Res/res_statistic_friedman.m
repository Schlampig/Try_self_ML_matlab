function res_statistic_friedman

% ���������ݼ���������������������ָ�꣬��������Щָ���Ӧ��std��ÿ���������������ݼ������������Ƿ�������
load('Res_BEFLD_related.mat'); 

AUC_score = get_score(AUC_mat);
Acc_score = get_score(Acc_mat);
GM_score = get_score(GM_mat);

AUC_std = get_std(AUC_std_mat);
Acc_std = get_std(Acc_std_mat);
GM_std = get_std(GM_std_mat);

save('Score_friedman_selected.mat','AUC_score','Acc_score','GM_score','AUC_std','Acc_std','GM_std');

end%function


function [Y] = get_score(X)
    % X���������ݼ������������Ƿ�������
    Y = [];
    Z = [];
    for i = 1:size(X,1)
        score = sort_friedman(X(i,:)); % ����Խ�ã�scoreԽС
        Y = [Y; [X(i,:);score]];
        Z = [Z;score];
        clear score;
    end%for_i
    m = mean(X); % ��ֵ
    m_score = sort_friedman(m); % ƽ��ֵ����������ֵԽ������ֵԽ��
    Y = [Y; [m;m_score;mean(Z)]]; % Y������зֱ���ָ�����X�ľ�ֵ����������ֵ�ĵ÷֣��Լ��Ե������ݼ��÷ֻ��ܺ�ľ�ֵ��scoreԽ���ʾ����Խ��
end%function


function [Y] = get_std(X)
    Y = -1*ones(2*size(X,1),size(X,2));
    Y(1:2:end,:) = X;
end%function

