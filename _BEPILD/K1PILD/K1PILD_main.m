function K1PILD_main(dataset_name, data_index, ktimes, par)

%�������Ժ˵Ľ���α���㷨������Ҫ������

%dp_index:����ѡ�����ɵ�dp������label����������

% ��ֵ
dp_index = par.dp;
num_reg = par.reg;
ker_type = par.ktype;
ker_par = par.kpara;

load(dataset_name);
dataname =  strcat('K1PILD_dp_',num2str(par.dp),'_reg_',num2str(par.reg),'_',par.ktype,num2str(par.kpara),Imbalanced_data{data_index,1});%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [w,w0] = K1PILD_train(train_all,par);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end