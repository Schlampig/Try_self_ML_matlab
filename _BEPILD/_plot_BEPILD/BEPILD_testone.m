function [pre_pos,pre_neg] = BEPILD_testone(test_data,model)


% ��������ʽ�����BEPILD_test��ֻ����һ��������ֻ����Ԥ������

% ���ݲ���
w = model.w;
w0 = model.w0;
bpos = model.bpos;
bneg =  model.bneg;
candi_dis_pos = model.candi_dis_pos;
candi_dis_neg = model.candi_dis_neg;
test_num = size(test_data,1);

% Ԥ��
pre_label = [];
for i = 1:test_num    
    x = test_data(i,:)';%������x
    ypos = w'*x + bpos;
    yneg = w'*x + bneg;

    if yneg <= 0%��������������
        label = 0;%����   
    elseif ypos >= 0%���Ҳ��������Ҳ�
        label = 1;%����      
    else%z���м�����
        test_dis_pos = abs(ypos);
        test_dis_neg = abs(yneg);
        p_pos = length(find(candi_dis_pos > test_dis_pos))/length(candi_dis_pos);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
        p_neg = length(find(candi_dis_neg > test_dis_neg))/length(candi_dis_neg);%ѵ�������бȲ���������Զ��ѵ�������������ڳ�ƽ��ĵ�ĸ���/�����ķ��������ѵ������������
        if p_pos > p_neg
            label = 1;
        elseif p_pos < p_neg
            label = 0;
        else%�������һ��������ʹ�ô�ͳ��α�������Ƚ�
            y = w'*x + w0;
            if y >= 0;%������
                label = 1;
            else%�Ǹ���
                label = 0;
            end%if
        end%if
    end%if    
    pre_label = [pre_label;label];    
end%for

pre_pos = test_data(find(pre_label==1),:);
pre_neg = test_data(find(pre_label==0),:);


end %function