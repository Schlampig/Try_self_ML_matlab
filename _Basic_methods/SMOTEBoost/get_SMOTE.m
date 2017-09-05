function [train_sub, k, r] = get_SMOTE(train_all, par)

% ʹ��SMOTE�ϲ���train_all�������������������ѵ����train_sub
% train_all, train_sub: ��������һ��һ�����������һ����label

% ��ֵ
k = par.k; % ���ڸ���
r = par.r; % ����������������

% �������������ݼ�����ż�
value_label = unique(train_all(:,end));
train_label = train_all(:,end);
if length(value_label) ~= 2   
    disp('Not a binary problem for undersampling!');
else
    if sum(train_label == value_label(1)) >= sum(train_label == value_label(2))
        train_pos = train_all(find(train_label == value_label(2)),:);
        train_neg = train_all(find(train_label == value_label(1)),:);
    else
        train_pos = train_all(find(train_label == value_label(1)),:);
        train_neg = train_all(find(train_label == value_label(2)),:);
    end%if
end%if
data_pos = train_pos(:,1:end-1);
n_pos = size(train_pos,1);
n_neg = size(train_neg,1);

% �жϲ����Ƿ�����ʵ�����r��k
if n_pos == 0
    disp('No positive samples!');
elseif k+1 > n_pos
    k = n_pos - 1;
else
    while k > 1 % ��k�����㹻С
        while r > 1 % ��r�����㹻С
            if n_pos + n_pos*k*r >= n_neg
                r = r - 1;
            else
                break;
            end % if
        end % while_r
        if n_pos + n_pos*k*r >= n_neg
            k = k - 1;
        else
            break;
        end % if
    end % while_k
end % if

% ��������
[~,i_neighbor] = pdist2(data_pos,data_pos,'euclidean','Smallest',k+1); % i_neighbor��k*N�ľ��󣬵�n���ǵ�n��������k���ڵ�index������һ�����������Լ��ľ��룬��Ҫȥ��
i_neighbor = i_neighbor(2:end,:)'; % N*k�е�index����

% �ϲ���
new_pos_mat = [];
for i = 1:n_pos
    now_sample = data_pos(i,:); % ȡ����ǰ��������
    for j = 1:k
        new_sample_mat = get_new_pos(now_sample, data_pos(i_neighbor(i,j),:), r);
        new_pos_mat = [new_pos_mat;new_sample_mat];
        clear new_sample_mat;
    end%for_j
end%for_i

% ��ԭ������������ϲ�����ѵ����
train_sub = [train_neg;train_pos;[new_pos_mat,train_pos(1,end)*ones(size(new_pos_mat,1),1)]]; 

end % function



function [neighbors] = get_new_pos(sample, neighbor, r)
% ���Լ���һ���ھ�֮�����r����
% sample��neighbor����������
    neighbors = [];
    for i_r = 1:r
        neighbors = [neighbors; sample + (sample - neighbor).* rand(size(sample))];
    end%for_i_r
end%function

