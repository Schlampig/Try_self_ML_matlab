function BEK3PILD_main(dataset_name, data_index,ktimes,Par)

% BEK3PILDģ�ͣ����þ����ӳ�佫����������ӳ�䵽�˿ռ䣬���ں˿ռ�����ͨ��BEPILD����

% dataset_name�� ������ݼ��ļ��ϵ�����
% data_index�� ���ݼ����
% ktimes: ����������һ��Ϊ5��10�֣��������ݼ�������
% dp_index:����ѡ�����ɵ�dp������label��ֵ������dp_Gernerate()
% num_reg: ����Ȩ�ز����������� reg=0�������Ŷ���regԽ���Ŷ�Խ��

% Ԥ����
ker_type = Par.ker_type;
ker_par = Par.ker_par;
load(dataset_name);
dataname =  strcat('BEK3PILD_',Imbalanced_data{data_index,1},'_dp',num2str(Par.dp),'_reg',num2str(Par.reg),'_',ker_type,num2str(ker_par));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc

% ѵ�������
for i_cv = 1:ktimes
   
   % ���þ����ӳ���ú˿ռ����ݼ�
   train_data = Imbalanced_data{data_index,3}{i_cv,1};
   test_data = Imbalanced_data{data_index,3}{i_cv,2}; 
   [ker_train, ker_test] = gen_empirical_ker_data(train_data(:,1:end-1), test_data(:,1:end-1), ker_type, ker_par); % ker_test = rxN2
   train_all = [ker_train',train_data(:,end)]; % N1x(r+1)
   test_all = [ker_test',test_data(:,end)];% N2x(r+1)

   % ѵ��
   [model,flag] = BEPILD_train(train_all, Par.dp, Par.reg);
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


end%function