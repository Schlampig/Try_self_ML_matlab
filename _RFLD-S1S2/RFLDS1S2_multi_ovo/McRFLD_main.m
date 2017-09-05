function McRFLD_main(par)

% �������õ�par�������ݼ�����ѧϰ��������

% ��ֵ
dataset_name = par.dataname;
data_index = par.fileindex;
ktimes = par.ktimes; % iterations of cross validation

% ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = [];%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���macro tpr��macro tnr��ppv��f1,acc,macc��gm,0.5*(acc+macc)

% ������֤
for i_cv = 1:ktimes
   % ������ݼ�
   train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
   test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
   train_all = get_preprocess(train_all);
   test_all = get_preprocess(test_all);
   
   % ����ѧϰ
   [pre_label] = McRFLD_fun(train_all, test_all, par);
   % ����
   vec_res = get_multi_evaluate(test_all(:,end), pre_label);
   
   %ͳ��һ�ֵĽ��
   final_res = [final_res;vec_res];    
end%for_i_cv

% ͳ��CVƽ�����
final_res = [final_res; mean(final_res)];
final_res = [final_res;std(final_res(1:end-1,:))];

% ������
parname = get_parname(par); % ��õ�ǰģ�ͳ�����������Ϣ�ַ���
final_name = strcat('Mc_', par.modelname, parname, file_name);%ת����ļ���
save(['res_data\',final_name,'.mat'],'final_res');

end % function


function [new_data] = get_preprocess(old_data)
% �����ݼ�Ԥ���������淶label��ֵ���Լ���һ������
    old_fea = old_data(:,1:end-1);
    % ��һ��
    new_fea = old_fea ./repmat(max(old_fea),size(old_fea,1),1); % data/max(data)����min-max��Ϊ�˱����һ�������ݳ���0
%     % ����һ��
%     new_fea = old_fea;
    new_gnd = normal_label(old_data(:,end));
    new_data = [new_fea, new_gnd];
end%function


function [new_label] = normal_label(old_label)
% ��old_label��ֵ����䵽��Ȼ������
    class_distribute = unique(old_label);
    c = length(class_distribute);%�������
    new_label = old_label;
    for i_c = 1:c
        new_label(find(old_label == class_distribute(i_c))) = i_c;
    end%for_i_c
end % function


function [par_string] = get_parname(par)
% �Ѳ�����ֵ����һ���ַ���
    names = fieldnames(par);
    par_string = '_';
    for i = 1: length(names)
        i_name = names{i};
        i_value = getfield(par,i_name);
        par_string = strcat(par_string,i_name,num2str(i_value),'_');
    end%for_i
end% function