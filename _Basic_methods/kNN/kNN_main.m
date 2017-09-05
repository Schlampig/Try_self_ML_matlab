function kNN_main(dataset_name, data_index, ktimes, k)

% �����kNNģ��

% dataset_name�� ������ݼ��ļ��ϵ�����
% data_index�� ���ݼ����
% ktimes: ����������һ��Ϊ5��10�֣��������ݼ�������
% k�����ڸ���

% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('kNN_',file_name,'_k',num2str(k));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc

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
   
   % ����
   [vec_res] = kNN_test(test_all, train_all, k);
   %ͳ��һ�ֵĽ��
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% ͳ�ƽ��
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% ������
save([dataname,'.mat'],'final_res');


end % function