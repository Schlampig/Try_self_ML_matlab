function SMOTE_RF(dataset_name, data_index, ktimes, nT, ksmote)

%ʹ��SMOTEԤ��������ɭ�ַ�������
%������Χ������û�б�����ƣ����Ű졣
%ktimes��MCCV����������1,2,3,...,10��
%nT:ɭ�������ĸ���

% Ԥ����
load([dataset_name,'.mat']);
file_name = eval([dataset_name,'{',num2str(data_index),',1}']);
dataname =  strcat('SmoteRF_',file_name,'_T',num2str(nT),'_ksmote',num2str(ksmote));%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѵ�������
for i_cv = 1:ktimes    
    % ������ݼ������һ��Ϊ����ǣ�
    if strcmp(dataset_name,'KEEL')   
        train_orig = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',1}']);
        test_all = eval([dataset_name,'{',num2str(data_index),',3}{',num2str(i_cv),',2}']);
        train_orig(:,end) = train_orig(:,end)+1; % label_pos = 2, label_neg =1
        test_all(:,end) = test_all(:,end)+1; 
    else
        train_orig = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',1}']); % label_pos = 2, label_neg =1
        test_all = eval([dataset_name,'{',num2str(data_index),',2}{',num2str(i_cv),',2}']);
    end%if
    
    % SMOTE����
    smote_Sample = [];
    Positive_Id = find(train_orig(:,end) == 2);%���������
    Negative_Id = find(train_orig(:,end) == 1);%���������
    if length(Negative_Id)/length(Positive_Id) >= 2; % �������������������������2������
        beta = floor(length(Negative_Id)/length(Positive_Id)/2);% ����ƽ���ʿ�����2����
        smote_Sample = SMOTE_Fuc(train_orig(Positive_Id,1:end-1), ksmote, beta);
        smote_Sample = [smote_Sample,2*ones(size(smote_Sample,1),1)];
    end %if
    train_all = [train_orig;smote_Sample];
    c = max(train_all(:,end)); % ������
    
    % ѵ��
    forest = TreeBagger(nT,train_all(:,1:end-1),train_all(:,end), 'Method', 'classification');%����ѵ��
    
    % ����
    [~,p_mat] = forest.predict(test_all(:,1:end-1)); 
    [~,label_pre] = max(p_mat,[],2); % �ҳ�ÿһ��������һ�еı�ţ��Ͷ�Ӧ�����
    label_test = test_all(:,end);
    
    % ͳ��һ�ֵĽ��
    final_res(i_cv,:) = get_binary_evaluate(label_pre, label_test);

end%for_i_cv

final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

save([dataname,'.mat'],'final_res');

            
end
            
            

