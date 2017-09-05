function LIkNN_main(data_index,ktimes,k,inf)

%���㲻ƽ�����ݼ���LIkNN�㷨

load Imbalanced_data.mat;
dataname =  strcat('LIkNN_',Imbalanced_data{data_index,1},'_Neighbor_',num2str(k),'_Inf_',num2str(inf));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ��󣬵����ڶ��д��ֵ�����һ��std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc

for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [vec_res] = LIkNN_test(train_all,test_all,k,inf);
   final_res(i_cv,:) = vec_res;
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

end