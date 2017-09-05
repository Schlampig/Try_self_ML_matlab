function ABRS_main(dataset_name, data_index, par)

% ���ò�ȡ����������ͶƱ���Եķ�������������
% ������Χ������û�б�����ƣ����Ű졣
% ktimes��MCCV����������1,2,3,...,10��
% par:��Ÿ�ģ����Ҫ�����Ľṹ��


% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('ABRS_SVM_',file_name,'_ts&tf',num2str(par.Ts),'&',num2str(par.Tf),'_rf',num2str(par.Rc),'_C',num2str(par.C),'_sigma',num2str(par.sigma));%ת����ļ���
final_res = zeros(par.ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TPR,TNR,PPV,F1,Acc,MAcc,GM,0.5(Acc+MAcc)

% ѵ�������
for i_cv = 1:par.ktimes    
    % ������ݼ������һ��Ϊ����ǣ�
    if strcmp(dataset_name,'KEEL')   
        train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_all(:,end) = train_all(:,end)+1;
        test_all(:,end) = test_all(:,end)+1;
    else
        train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if

    % ѵ��&����
        [vec_res] = ABRS_fun(train_all, test_all, par);
   
    %ͳ��һ�ֵĽ��
    final_res(i_cv,:) = vec_res;  
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));

save([dataname,'.mat'],'final_res');
            
end % function
            
            

