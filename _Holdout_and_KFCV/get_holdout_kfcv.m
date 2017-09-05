function get_holdout_kfcv(name, k_out, k_in)

% ���룺һ�����ݼ��ṹ��d��fea��һ��һ�����������ݼ�����gnd�Ƕ�Ӧ��label������
%       k_out,k_in�ֱ��������ڲ��������
%       name�����ݼ�����
% �����һ��cell����һ���������ƣ��ڶ����ڲ���ѵ�����ԣ�������holdout��

% Ԥ����
d = load([name,'.mat']);
fea = d.fea;
[gnd,~] = normal_label(d.gnd); % ��label��1��ʼ

% ����k����֤
[i_learn, i_holdout] = get_kholdout(gnd, k_out);
for i_out =  1:k_out
    fea_learn = fea(i_learn{i_out},:);
    gnd_learn = gnd(i_learn{i_out});
    
    [i_train, i_valid] = get_kholdout(gnd_learn, k_in);
    for i_in =  1:k_in
        now_data{i_in,1} = [fea_learn(i_train{i_in},:),gnd_learn(i_train{i_in})];
        now_data{i_in,2} = [fea_learn(i_valid{i_in},:),gnd_learn(i_valid{i_in})];
    end%for_i_in
    data{i_out,1} = strcat('CV_',num2str(i_out));
    data{i_out,2} = now_data;
    data{i_out,3} = [fea(i_holdout{i_out},:),gnd(i_holdout{i_out})];
    clear now_data;clear fea_learn;clear gnd_learn;
    
end%for_i_out

% �洢����
T5x5 = data;
save('T5x5.mat','T5x5');   

end % function


function [new_label, c] = normal_label(old_label)
% ��old_label��ֵ����䵽��Ȼ������
    class_distribute = unique(old_label);
    c = length(class_distribute);%�������
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c

end % function



function [learn_cell, holdout_cell] = get_kholdout(v, k)
% �������������v����֤����k�ֳ�ѧϰ����Ԥ�⼯

    slice_vec = crossvalind('Kfold', v, k);
    for j = 1:k
        holdout_vec = (slice_vec == j);
        learn_vec = ~holdout_vec;
        learn_cell{j} = learn_vec;
        holdout_cell{j} = holdout_vec;
        clear learn_vec; clear holdout_vec;
    end% for_j
     
end % function


