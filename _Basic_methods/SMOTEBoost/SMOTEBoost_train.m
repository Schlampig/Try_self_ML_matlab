function [method, basic_clf_name] = SMOTEBoost_train(train_all, par)

% ѵ��SMOTEBoost�ĺ���������汾ֻ�ܴ��������������
% train_all: ѵ��������һ��һ�����������һ����label��

% ��ֵ
T =  par.T; % ������=������������
N = size(train_all,1); % ��������

% ѵ��
D = 1/N * ones(N,1);
for i = 1:T
    [train_sub, k, r] = get_SMOTE(train_all, par);
    [method(i).clf, now_clf_name] = model_train(train_sub, par);  
    [pre_label] = model_predict(train_all, method(i).clf, par);
    e_vec = (pre_label ~= train_all(:,end)); % ����ʱΪ1�����ʱΪ0
    e = sum(D.*e_vec);  
    if e == 0
        e = 0.000001;
    end%if
    method(i).a = 0.5*log((1-e)/e); % matlab��log()�����Ǽ�����Ȼ�������൱��ln
    D = get_new_D( D, method(i).a, e_vec);
    clear e_vec; clear e;    
end%for
basic_clf_name = strcat('k',num2str(k),'_r',num2str(r),'_',now_clf_name);

end % function