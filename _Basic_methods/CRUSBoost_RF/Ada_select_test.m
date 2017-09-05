function [res] = Ada_select_test(test_all, method, par, candi_vec)

% ����AdaBoost�ĺ���������汾ֻ�ܴ�������������⣬����candi_vec��ѡ������������������������в���
% test_all�����ݼ�����һ��һ�����������һ����Label
% candi_vec����������ÿ��entry�ǻ���������method�ṹ���������

T = length(candi_vec); % ������=ѡ���Ļ�����������
c = length(unique(test_all(:,end))); % ������
sub_label = [];
a = [];
for i = 1:T     
    temp_pre = model_predict(test_all, method(candi_vec(i)).clf, par);
    sub_label = [sub_label, temp_pre]; 
    a = [a, method(candi_vec(i)).a];    
end%for_i

pre_label = [];
for j = 1:size(sub_label,1)
    pre_label = [pre_label; get_vote_pre(sub_label(j,:), a, c)];
end%for_j

[res] = get_binary_evaluate(pre_label, test_all(:,end));   

end % function