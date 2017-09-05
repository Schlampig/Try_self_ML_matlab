function K3PILD_main(dataset_name, data_index, ktimes, Par)

%���㲻ƽ�����ݼ��Ľ���α���㷨������Ҫ������

%dp_index:����ѡ�����ɵ�dp������label����������

%��ʼ��
ker_type = Par.ker_type;
ker_par = Par.ker_par;
dp_index = Par.dp;

load(dataset_name);
dataname =  strcat('K3PILD_dp_',num2str(dp_index),'_',ker_type,num2str(ker_par),'_',Imbalanced_data{data_index,1});%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   % ���þ����ӳ���ú˿ռ����ݼ�
   train_data = Imbalanced_data{data_index,3}{i_cv,1};
   test_data = Imbalanced_data{data_index,3}{i_cv,2}; 
   [ker_train, ker_test] = gen_empirical_ker_data(train_data(:,1:end-1), test_data(:,1:end-1), ker_type, ker_par); % ker_test = rxN2
   train_all = [ker_train',train_data(:,end)]; % N1x(r+1)
   test_all = [ker_test',test_data(:,end)];% N2x(r+1) 
   
   [w,w0] = PILD_train(train_all,dp_index);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end