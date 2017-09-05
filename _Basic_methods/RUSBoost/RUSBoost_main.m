function RUSBoost_main(dataset_name, data_index, par)

% RUSBoost��������
% ������Χ������û�б�����ƣ����Ű졣
% ktimes��MCCV����������1,2,3,...,10��
% par:��Ÿ�ģ����Ҫ�����Ľṹ��

% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = zeros(par.ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѧϰ
for i_cv = 1:par.ktimes    
    % ������ݼ������һ��Ϊ����ǣ�
    if strcmp(dataset_name,'KEEL')   
        train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_all(:,end) = get_new_label(train_all(:,end));
        test_all(:,end) = get_new_label(test_all(:,end));
    else
        train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if

    % ѵ��&����&��¼
    [method, clf_name] = RUSBoost_train(train_all, par);
    final_res(i_cv,:) = Ada_test(test_all, method, par);
    
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));
final_name = strcat('RUSBoost_',file_name,'_iter',num2str(par.T),'_',clf_name);

save([final_name,'.mat'],'final_res');
