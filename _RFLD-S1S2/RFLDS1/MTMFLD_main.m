function MTMFLD_main(dataset_name,data_index,ktimes,dp,reg,c,theta,k)

% ���㲻ƽ�����ݼ��Ķ���ֵFisher�㷨������Ҫ����������Ҫѡ��ʹ����һ��w0��
% theta:ѡ����ֵ��tag��һ����1-11����ֵ��ѡ����һ��ʵ����ֻȡ2-11��
% c���ͷ����ӣ�cSw+(1-c)Slw
% k������Slwʱ��Ҫ�Ľ�������

load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('MTMFLD_reg_',num2str(reg),'_dp_',num2str(dp),'_c_',num2str(c),'_k_',num2str(k),'_',file_name);%ת����ļ���

final_res = [];%��¼ÿ��theat��ƽ�����
for i_theta = 1:length(theta)
%     subdataname =  strcat('MTMFLD_dp',num2str(dp),'_reg',num2str(reg),'_theta',num2str(theta(i_theta)),'_c',num2str(c),'_k',num2str(k),'_',file_name);%ת����ļ���
    sub_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=
    for i_cv = 1:ktimes
       train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
       test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']); 

       [w,w0] = MTMFLD_train(train_all,dp,reg,c,theta(i_theta),k);
       [vec_res] = PILD_test(test_all,w,w0);
       sub_res(i_cv,:) = vec_res;     
    end%for_i_cv
    sub_res(ktimes+1,:) = mean(sub_res(1:ktimes,:));
    sub_res(ktimes+2,:) = std(sub_res(1:ktimes,:));
%     save([subdataname,'.mat'],'sub_res');
    
    final_res = [final_res;mean(sub_res(1:ktimes,:))];
%     clear sub_res; clear subdataname;
    
end%for_i_theta

final_res = [final_res; mean(final_res)];
final_res = [final_res; max(final_res)];%�������㷨��ȣ�MTMFLD�����һ��
final_res = [final_res; std(final_res)];

save([dataname,'.mat'],'final_res');

end