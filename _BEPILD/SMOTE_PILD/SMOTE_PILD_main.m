function SMOTE_PILD_main(data_index,ktimes,dp_index,beta)

%���㲻ƽ�����ݼ���SMOTE����α���㷨������Ҫ������

%dp_index:����ѡ�����ɵ�dp������label����������

load Imbalanced_data.mat;
dataname =  strcat('SMOTE_PILD_dp_',num2str(dp_index),'_',Imbalanced_data{data_index,1},'_SMOTE_beta_',num2str(beta));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   train_orig = Imbalanced_data{data_index,3}{i_cv,1};
   smote_Sample = [];
   Positive_Id = find(train_orig(:,end) == 1);%���������
   Negative_Id = find(train_orig(:,end) == 0);%���������
   %if length(Negative_Id)/length(Positive_Id) >= 2;%�������������������������smote������
        %beta = floor(length(Negative_Id)/length(Positive_Id)/2);% ����ƽ���ʿ�����2����
        ksmote = 5;
        smote_Sample = SMOTE_Fuc(train_orig(Positive_Id,1:end-1), ksmote, beta);
        smote_Sample = [smote_Sample,ones(size(smote_Sample,1),1)];
   %end  
   
   train_all = [train_orig;smote_Sample];
   test_all = Imbalanced_data{data_index,3}{i_cv,2}; 

   
   [w,w0] = SMOTE_PILD_train(train_all,dp_index);
   [vec_res] = SMOTE_PILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end