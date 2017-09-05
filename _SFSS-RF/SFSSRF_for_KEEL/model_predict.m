function [pre_label] = model_predict(data, clf, tag)

% ����tagѡ��ʹ�õ�ģ�Ͷ��������в���
% data:һ��һ�����������һ����label
% clf:classifier��������ѵ���õ�ģ��
% tag:����ѡ���������Ե�ģ��


switch tag
    case 0 % ֧��������
        pre_label = svmclassify(clf,data(:,1:end-1));
    case 1 % k����
        pre_label = kNN_test(data, clf.train_all , clf.c, clf.k, clf.metric);
    case 2 % ���ɭ��
        [~,p_mat] = clf.predict(data(:,1:end-1));
        [~, pre_label] = max(p_mat,[],2); % �ҳ�ÿһ��������һ�еı�ţ��Ͷ�Ӧ����� 
    case 3 % ֧��������
        pre_label = svmclassify(clf,data(:,1:end-1));    
end%switch        

end%function 