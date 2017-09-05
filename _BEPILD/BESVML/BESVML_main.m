function BESVML_main(dataset_name, data_index,ktimes,C)

%ʹ��SVM��linear�����ɱ߽�ķ���

% dataset_name�� ������ݼ��ļ��ϵ�����
% data_index�� ���ݼ����
% ktimes: ����������һ��Ϊ5��10�֣��������ݼ�������
% C: �ɳڲ���

% Ԥ����
load(dataset_name);
dataname =  strcat('BESVML_',Imbalanced_data{data_index,1},'_C',num2str(C));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѵ�������
for i_cv = 1:ktimes
   % ������ݼ�
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   % ѵ��
   [model,flag] = BESVML_train(train_all,C);
   % ����
   if flag == 1 % �ɷ����Σ�����Ҫʹ������ʽ�㷨
       [vec_res] = SVML_test(test_all,model);
   elseif flag == 0 %�ص����Σ���Ҫʹ������ʽ�㷨
       [vec_res] = BESVML_test(test_all,model);
   end%if
   %ͳ��һ�ֵĽ��
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% ͳ�ƽ��
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% ������
save([dataname,'.mat'],'final_res');


end