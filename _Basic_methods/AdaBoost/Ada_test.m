function [res] = Ada_test(test_all, method, par)

% ����AdaBoost�ĺ���������汾ֻ�ܴ��������������
% test_all�����ݼ�����һ��һ�����������һ����Label

T = par.T; % ������=������������
c = length(unique(test_all(:,end))); % ������
sub_label = [];
a = [];
for i = 1:T     
    temp_pre = model_predict(test_all, method(i).clf, par);
    sub_label = [sub_label, temp_pre]; 
    a = [a, method(i).a];    
end%for_i

pre_label = [];
for j = 1:size(sub_label,1)
    pre_label = [pre_label; get_vote_pre(sub_label(j,:), a, c)];
end%for_j

[res] = get_binary_evaluate(pre_label, test_all(:,end));   

end % function