function [label_pre] = RFLDS2_test(test_all, clf)

% ����RFLDS2�ĺ���
% test_all��һ��һ����������label

% ���ݲ���
if clf.flag == 1 % �ɷ����Σ�����Ҫʹ������ʽ�㷨
    label_pre = RFLD_test(test_all, clf);
elseif clf.flag == 0 %�ص����Σ���Ҫʹ������ʽ�㷨
    w = clf.w;
    w0 = clf.w0;
    bpos = clf.bpos;
    bneg =  clf.bneg;
    candi_dis_pos = clf.candi_dis_pos;
    candi_dis_neg = clf.candi_dis_neg;
    % ����
    label_pre = [];
    for i_test = 1:size(test_all,1)   
        x = test_all(i_test,1:end-1)';
        ypos = w'*x + bpos;
        yneg = w'*x + bneg;
        if yneg <= 0%��������������
            label_temp = 0;%����
        elseif ypos >= 0%���Ҳ��������Ҳ�
            label_temp = 1;%����      
        else%z���м�����
            test_dis_pos = abs(ypos);
            test_dis_neg = abs(yneg);
            p_pos = length(find(candi_dis_pos > test_dis_pos))/length(candi_dis_pos);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
            p_neg = length(find(candi_dis_neg > test_dis_neg))/length(candi_dis_neg);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
            if p_pos > p_neg
                label_temp = 1;
            elseif p_pos < p_neg
                label_temp = 0;
            else%�������һ��������ʹ�ô�ͳ��α�������Ƚ�
                y = w'*x + w0;
                if y >= 0;%������
                    label_temp = 1;
                else%�Ǹ���
                    label_temp = 0;
                end%if
            end%if
        end%if
        label_pre = [label_pre;label_temp];
        clear label_temp;
    end%for_i_test
end%if

end % function