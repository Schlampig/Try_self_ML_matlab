function [res] = get_multi_evaluate(label_test, label_pre)

% ����Ԥ�������������ʵ�����������ģ�͵ı��֣����������Ϊ������
% ֻ�ʺ϶��������⣬ label��1��ʼ

% ͳ��һ�ֵĽ��
[label_test,c] = normal_label(label_test); 
[label_pre,~] = normal_label(label_pre);
cmp_label = (label_pre ~= label_test); % ��Ԥ��������������Ϊ1����ȷ��Ϊ0

R = [];
for i_c = 1:c
    if isempty(cmp_label(find(label_test == i_c)))
        cmp_now = 0;
    else
        cmp_now = cmp_label(find(label_test == i_c));
    end%if
    False_now = sum(cmp_now); % ��ǰ���ֵ���������
    True_now = length(cmp_now) - False_now; % ��ǰ����ȷ����������
    R = [R;[True_now, False_now]];
    clear True_now; clear False_now;
end%for_i_c

tpr_vec = R(:,1)./(R(:,1)+R(:,2));
Acc = sum(R(:,1))/sum(R(:,1)+R(:,2)); % �ܷ��ྫȷ��
AA = mean(tpr_vec); % ����ƽ��TPR
GM = nthroot(prod(tpr_vec),length(tpr_vec)); % ����ƽ��TPR
All = mean([Acc,AA]); % Acc��AA��ֵ

res = [-1,-1,-1,-1,Acc,AA,GM,All]*100;

end %function

function [new_label, c] = normal_label(old_label)
% ��old_label��ֵ����䵽��Ȼ������
    class_distribute = unique(old_label);
    c = length(class_distribute);%�������
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c

end % function


