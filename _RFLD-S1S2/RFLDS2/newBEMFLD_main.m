function newBEMFLD_main(dataset_name, data_index, ktimes, dp_index, num_reg, k, c)

%����BEFLDģ�ͣ���������ѡ�񣬼��߽��жϣ�ʹ��cSw+(1-c)Slw��ȡ������Ϣ��Fisher������

% dataset_name�� ������ݼ��ļ��ϵ�����
% data_index�� ���ݼ����
% ktimes: ����������һ��Ϊ5��10�֣��������ݼ�������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()
% num_reg: ����Ȩ�ز����������� reg=0�������Ŷ���regԽ���Ŷ�Խ��
% k������Slw��Ҫ���ڸ���
% c��Ȩֵ���ӣ�cSw+(1-c)Slw


% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('newBEMFLD','_dp',num2str(dp_index),'_reg',num2str(num_reg),'_c',num2str(c),'_k',num2str(k),'_',file_name);%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѵ�������
for i_cv = 1:ktimes
   % ������ݼ�
   train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
   test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
   % ѵ��
   [model,flag] = newBEMFLD_train(train_all,dp_index,num_reg,k,c);
   % ����
   if flag == 1 % �ɷ����Σ�����Ҫʹ������ʽ�㷨
       [vec_res] = PILD_test(test_all,model);
   elseif flag == 0 %�ص����Σ���Ҫʹ������ʽ�㷨
       [vec_res] = BEPILD_test(test_all,model);
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