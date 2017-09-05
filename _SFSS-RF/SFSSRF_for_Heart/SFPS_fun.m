function [vec_res, name, weight] = SFPS_fun(train_all, test_all, par)


% ʹ�÷ֿ���ԵĿ�ܣ�Samples & Featrues Partition Strategy����Ŀǰֻ�����ڶ���������
% train_all/test_all�� ѵ��/���Ծ���һ��һ�����������һ����lable��min(label)=1
% par����¼����Ĳ���������par.model����ѡ���������
% model�����ڷ����������ݵĽṹ�塣


% ��ʼ������
n_class = 2;
n_sample = par.n_sample;

% ����sub���ݼ�
[train_cell] = sample_partition(train_all, par.ratio, par.n_sample); % sample_parttition��������Ƭ�������Ǿ��󣩣�fea_partition��������Ƭ�������ǰ��壩,����ֵ����label��
[train_sub, n_fea] = fea_partition(train_cell, par); 

% �ֿ�ѵ��
for i_s = 1:n_sample
    for i_f = 1:n_fea
        [clf{i_s,i_f}, name] = model_train(train_sub{i_s,i_f}, par); % train_sub��n_sample��n_fea�еİ���(cell)
    end%for_i_f
end%for_i_s
name = strcat(name,'_ratio_',num2str(par.ratio),'_s&f',num2str(n_sample),'x',num2str(n_fea)); % ��ʵ������

% �ֿ���֤
validate_label = train_all(:,end);
for j_f = 1:n_fea
    [validate_now,~] = fea_partition({train_all}, par); % ���ص�validata_sub����Ϊ1����Ϊn_fea�İ���(cell)
    for j_s = 1:n_sample   
        pre_label = model_predict(validate_now{1,j_f}, clf{j_s,j_f}, par.model); % predict����ÿ���㷨��Ԥ������Ȩ��
        res_validate{j_s,j_f} = get_binary_evaluate(pre_label, validate_label); % res_validate{j_s,j_f}�Ǹ�������
        clear pre_label;
    end%for_j_s
end%for_j_f

% ��ȡ�ֿ�ģ�����Ŷ�
weight = zeros(n_sample, n_fea);
for w_s = 1:n_sample
    for w_f = 1:n_fea   
        weight(w_s,w_f) = sum(res_validate{w_s,w_f}.* par.target)/length(find(par.target ~= 0)); %��targetָ��λ�õ�indicatorΪ����ָ��
    end%for_i_f
end%for_i_s
weight = (weight - min(min(weight)))./ (max(max(weight)) - min(min(weight)));

% �ֿ����
score_mat = [];
[test_now,~] = fea_partition({test_all}, par);
for k_s = 1:n_sample
    for k_f = 1:n_fea
        pre_label = model_predict(test_now{1,k_f}, clf{k_s,k_f}, par.model); %pre.lable������һ����������������test����������
        score_mat = [score_mat, [pre_label; weight(k_s,k_f)] ];%��Ӧ�����������Ŷȷ������һ��
        clear pre_label;
    end%for_k_f
end%for_k_s
final_pre_vec = get_final_pre(score_mat, n_class); %�õ�����Ԥ�����������
true_test_label = test_all(:,end); %��ʵ�����

% ����
vec_res = get_binary_evaluate(final_pre_vec, true_test_label);

end%function