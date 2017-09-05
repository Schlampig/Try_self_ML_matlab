function [clf, name] = model_train(data, par)

% ����tagѡ��ʹ�õ�ģ�Ͷ���������ѵ��
% data:һ��һ�����������һ����label
% clf:classifier��������ѵ���õ�ģ��


tag = par.model; % tag:����ѡ���������Ե�ģ��
switch tag
    case 0 % RBF֧��������
        option=svmsmoset('MaxIter',par.maxtime);
        clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','rbf','rbf_sigma',par.sigma,'method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        name = strcat('SVM_rbf_','_C',num2str(par.C),'_sigma',num2str(par.sigma),'_maxt',num2str(par.maxtime));
    case 1 % k����
        clf.c = length(unique(data(:,end))); % ������
        clf.k = par.k; % ������
        clf.train_all = data; % ������������
        clf.metric = par.metric; %ѡ�������ʽ
        name = strcat('kNN_k',num2str(par.k),'_metric',num2str(par.metric));
    case 2 % ���ɭ��
        clf = TreeBagger(par.T,data(:,1:end-1),data(:,end), 'Method', 'classification'); 
        name = strcat('RF_T',num2str(par.T));
    case 3 % ����֧��������
        option=svmsmoset('MaxIter',par.maxtime);
        clf = svmtrain(data(:,1:end-1),data(:,end),'kernel_function','linear','method','SMO','boxconstraint',par.C,'SMO_OPTS',option);
        name = strcat('SVM_linear_','_C',num2str(par.C),'_maxt',num2str(par.maxtime));
end%switch  


end % function