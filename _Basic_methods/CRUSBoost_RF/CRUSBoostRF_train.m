function [method, candi_vec, basic_clf_name] = CRUSBoostRF_train(train_all, par)

% ѵ��CRUSBoost�ĺ���������汾ֻ�ܴ��������������
% train_all: ѵ��������һ��һ�����������һ����label��

% ��ֵ
T =  par.T; % ������=������������
N = size(train_all,1); % ��������

% ѵ��
D = 1/N * ones(N,1);
candi_vec = [];
threshold = 0; % ѡ�����������ϵ����۱�׼��0-100
for i = 1:T
    train_sub = get_CRUS(train_all, par);
    [method(i).clf, basic_clf_name] = model_train(train_sub, par);
    [pre_label] = model_predict(train_all, method(i).clf, par);
    e_vec = (pre_label ~= train_all(:,end)); % ����ʱΪ1�����ʱΪ0
    e = sum(D.*e_vec);  
    if e == 0
        e = 0.000001;
    end%if
    method(i).a = 0.5*log((1-e)/e); % matlab��log()�����Ǽ�����Ȼ�������൱��ln
    
    res_now = Ada_select_test(train_all, method, par, [candi_vec, i]); % ��ѵ��������֤��
    if res_now(par.validation) > threshold
        threshold = res_now(par.validation);
        candi_vec = [candi_vec, i];
    end%if
    
    D = get_new_D( D, method(i).a, e_vec);
    clear e_vec; clear e;    
end%for

end % function