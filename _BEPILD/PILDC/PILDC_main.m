function PILDC_main(data_index,ktimes,dp_index)

%���㲻ƽ�����ݼ��Ľ���α���㷨������Ҫ������

%dp_index:����ѡ�����ɵ�dp������label����������

load Imbalanced_data.mat;
dataname =  strcat('PILDC_dp_',num2str(dp_index),'_',Imbalanced_data{data_index,1});%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=aa
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 
   
   [w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg] = PILDC_train(train_all,dp_index);
   [vec_res] = PILDC_test(test_all,w,w0,bpos,bneg,candi_dis_pos,candi_dis_neg);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end