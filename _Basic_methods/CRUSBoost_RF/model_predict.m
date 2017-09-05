function [pre_label] = model_predict(data, clf, par)

% ����tagѡ��ʹ�õ�ģ�Ͷ��������в���
% data:һ��һ�����������һ����label
% clf:classifier��������ѵ���õ�ģ��

model_name = par.model_name; % tag:����ѡ���������Ե�ģ��
if strcmp(model_name,'ID3')
    pre_label = treeval(clf,data(:,1:end-1));
elseif strcmp(model_name,'CART')
    pre_label = treeval(clf,data(:,1:end-1));
elseif strcmp(model_name,'SVM_RBF')
    pre_label = svmclassify(clf,data(:,1:end-1));    
elseif strcmp(model_name,'SVM_Linear')
    pre_label = svmclassify(clf,data(:,1:end-1));    
elseif strcmp(model_name,'RF')
    [~,p_mat] = clf.predict(data(:,1:end-1));
    [~, pre_label] = max(p_mat,[],2); % �ҳ�ÿһ��������һ�еı�ţ��Ͷ�Ӧ�����
end%if
    

end%function 