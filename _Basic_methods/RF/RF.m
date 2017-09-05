function RF(dataset_name, data_index, ktimes, nT)

%ѧϰ��ƽ�����ݼ������ɭ�ַ�������
%������Χ������û�б�����ƣ����Ű졣
%ktimes��MCCV����������1,2,3,...,10��
%nT:ɭ�������ĸ���

% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('RF_',file_name,'_T',num2str(nT));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѵ�������
for i_cv = 1:ktimes    
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
    c = max(train_all(:,end)); % ������
    
    % ѵ��
    forest = TreeBagger(nT,train_all(:,1:end-1),train_all(:,end), 'Method', 'classification');%����ѵ��
   
    % ����
    [~,p_mat] = forest.predict(test_all(:,1:end-1)); 
    [~,label_pre] = max(p_mat,[],2); % �ҳ�ÿһ��������һ�еı�ţ��Ͷ�Ӧ�����
    label_test = test_all(:,end);
    
    % ͳ��һ�ֵĽ��
    final_res(i_cv,:) = get_binary_evaluate(label_pre,label_test);

end%for_i_cv

final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

end % function
