function [res] = get_binary_evaluate(label_pre, label_test)

% ����Ԥ�������������ʵ�����������ģ�͵ı��֣����������Ϊ������
% ֻ�ʺ϶��������⣬ label��1��ʼ

% ͳ��һ�ֵĽ��
[label_pre,~] = normal_label(label_pre);
[label_test,c] = normal_label(label_test);    
cmp_label = (label_pre ~= label_test); % ��Ԥ��������������Ϊ1����ȷ��Ϊ0

res_temp = [];
for i_c = 1:c
    if isempty(cmp_label(find(label_test == i_c)))
        cmp_now = 0;
    else
        cmp_now = cmp_label(find(label_test == i_c));
    end%if
    False_now = sum(cmp_now); % ��ǰ���ֵ���������
    True_now = length(cmp_now) - False_now; % ��ǰ����ȷ����������
    res_temp = [res_temp;[True_now, False_now]];
    clear True_now; clear False_now;
end%for_i_c

TP = res_temp(2,1);
FN = res_temp(2,2);
TN = res_temp(1,1);
FP = res_temp(1,2);
TPR = TP/(TP+FN);
TNR = TN/(TN+FP);
if TP + FP == 0
    PPV = 0;
else
    PPV = TP/(TP+FP);
end%if_PPV

if PPV + TPR == 0
    F1 = 0;
else
    F1 = 2*PPV*TPR/(PPV+TPR);
end%if_F1

Acc = (TP+TN)/(TP+FN+TN+FP); % �ܷ��ྫȷ��
AA = mean([TPR,TNR]); % ����ƽ����ȷ��
GM = sqrt(TPR*TNR);%����ƽ����ȷ��
All = mean([Acc,AA]); % Acc��AA��ֵ


res = [TPR,TNR,PPV,F1,Acc,AA,GM,All]*100;

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


