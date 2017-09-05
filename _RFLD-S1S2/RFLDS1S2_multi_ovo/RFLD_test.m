function [label_pre] = RFLD_test(test_all, clf)

% ����RFLD�ĺ���
% test_all��һ��һ����������label

% ���ݲ���
w = clf.w;
w0 = clf.w0;
% ����
label_pre = [];
for i_test = 1:size(test_all,1)   
    x = test_all(i_test,1:end-1)';
    y = w'*x + w0;
    if y >= 0;%������
        label_temp = 1;
    else%�Ǹ���
        label_temp = 0;
    end%if
    label_pre = [label_pre;label_temp];
    clear label_temp;  
end%for_i_test

end % function