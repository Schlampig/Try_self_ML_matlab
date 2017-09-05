function MTFLD_main(dataset_name,data_index,ktimes,dp,reg,theta)

%���㲻ƽ�����ݼ��Ķ���ֵFisher�㷨������Ҫ����������Ҫѡ��ʹ����һ��w0��


load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('MTFLD','_dp',num2str(dp),'_reg',num2str(reg),'_theta',num2str(theta),'_',file_name);%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

for i_cv = 1:ktimes
   train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
   test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
   
   [w,w0] = MTFLD_train(train_all,dp,reg,theta);
   [vec_res] = PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
   
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end