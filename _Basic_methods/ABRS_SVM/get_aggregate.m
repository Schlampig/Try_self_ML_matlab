function [res] = get_aggregate(vote_mat)

% ����ͶƱ����ͳ��ÿһ�е�Ʊ���õ�����Ԥ��������label��1��ʼ
    num_class = length(unique(vote_mat)); % ������
    res = [];
    for i = 1:size(vote_mat,1)
        res = [res;cal_vote(vote_mat(i,:), num_class)];
    end%for_i
end % function

function [pre_label] = cal_vote(res_vec, c)

label_vec = zeros(1,c);
for j = 1:c
    label_vec(1,j) = sum(res_vec == j);
end%for_j

temp_label = find(label_vec == max(label_vec)); % �ҳ������
if length(temp_label) > 1 % ���ֲ�����
    pre_label = -1;
else
    pre_label = temp_label;
end%if


end % function