function DPILD_main(data_index,ktimes,dp_index)

%����α���㷨

%dp_index:����ѡ�����ɵ�dp������label����������

load Imbalanced_data.mat;
dataname =  strcat('PILD_dp_',num2str(dp_index),'_',Imbalanced_data{data_index,1});%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=
ir = Imbalanced_data{data_index,2};
for i_cv = 1:ktimes
   train_all = Imbalanced_data{data_index,3}{i_cv,1};
   test_all = Imbalanced_data{data_index,3}{i_cv,2};
   
   %����ѵ���׶�
   [row_train,col_train] = size(train_all);
   train_neg = train_all(find(train_all(:,end)==0),:);%��ʼ���и���ѵ������
   train_pos = train_all(find(train_all(:,end)==1),:);%��ʼ��������ѵ������
   %��һ�ֵ���
   [w,w0] = DPILD_train(train_all,dp_index);%��һ�ֵõ���Ȩ��
   [vec_res] = DPILD_test(train_all,w,w0);
   Acc2 = vec_res(6);
   GM = vec_res(7); 
   %��һ������
   for i_max = 1:300%��������
        if (size(train_pos,1)<2) || (size(train_neg,1)<2)%�����һ������������2����ֹͣ
            break;
        else
            uneg = mean(train_all(find(train_all(:,end)==0),1:col_train-1),1)';%��ǰѵ������������ľ�ֵ�㣨���ģ���������
            upos = mean(train_all(find(train_all(:,end)==1),1:col_train-1),1)';
            value_neg = w'*uneg + w0;
            value_pos = w'*upos + w0;
            value_min = min([value_neg,value_pos]);
            value_max = max([value_neg,value_pos]);
            vec_sum = sum(repmat(w',size(train_all,1),1) .* train_all(:,1:col_train-1),2) + w0*ones(size(train_all,1),1);%��ǰѵ��������w'*x��һ������
            train_tempor = train_all(intersect(find(vec_sum>value_min),find(vec_sum<value_max)),:);%�ҳ����������ļ��������Ϊ��һ�ֵĵ���
            clear train_all;
            train_all = train_tempor;       
            [w,w0] = DPILD_train(train_all,dp_index);%��Ȩ�ؼ���
            [vec_res] = DPILD_test(train_all,w,w0);
            acc2 = vec_res(6);%��һ��acc2��gm
            gm = vec_res(7);
         end%end_size
         
         if (acc2 >= Acc2) && (gm>=GM)
             Acc2 = acc2;
             GM = gm;
             continue;
         else
             break;
         end%if_tag
      
    end%for_i_max
  
   [vec_res] = DPILD_test(test_all,w,w0);
   final_res(i_cv,:) = vec_res;  
end%for_i_cv
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');


end