function SFPS_main(dataset_name, data_index, par)

% ���ò�ȡ����������ͶƱ���Եķ�������������
% ������Χ������û�б�����ƣ����Ű졣
% ktimes��MCCV����������1,2,3,...,10��
% par:��Ÿ�ģ����Ҫ�����Ľṹ��


% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
final_res = zeros(par.ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

r_w = 1;%��ʼ��cell�ļ���
% ѵ�������
for i_cv = 1:par.ktimes    
    % ������ݼ������һ��Ϊ����ǣ�
    if strcmp(dataset_name,'KEEL')   
        train_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_all(:,end) = train_all(:,end)+1;
        test_all(:,end) = test_all(:,end)+1;
    else
        train_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if

    % ѵ��&����
        [vec_res, name, w] = SFPS_fun(train_all, test_all, par);
        dataname =  strcat('SFPS_',file_name,'_',name,'_w&s_',num2str(par.window),'&',num2str(par.step));%ת����ļ��� 
   
    %ͳ��һ�ֵĽ��
    final_res(i_cv,:) = vec_res;  
    w_all{1,r_w} = [w; mean(w)];
    r_w = r_w + 1;
end%for_i_cv

final_res(par.ktimes+1,:) = mean(final_res(1:par.ktimes,:));
final_res(par.ktimes+2,:) = std(final_res(1:par.ktimes,:));

save([dataname,'.mat'],'final_res', 'w_all');
            
end
            
            

