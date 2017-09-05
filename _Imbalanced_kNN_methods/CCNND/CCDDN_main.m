function CCDDN_main(data_index,ktimes,k)

%���㲻ƽ�����ݼ���CCDDN�㷨

load Imbalanced_data.mat;
dataname =  strcat('CCDDN_',Imbalanced_data{data_index,1},'_k_',num2str(k));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ��󣬵����ڶ��д��ֵ�����һ��std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [vec_res] = CCDDN_test(train_all,test_all,k);
   final_res(i_cv,:) = vec_res;
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

end