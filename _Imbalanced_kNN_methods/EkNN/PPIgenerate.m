function [train_all_new] = PPIgenerate(z,delta,train_all)

%��ѵ������Ѱ��PPI��������������

    %train_pos = train_all(find(train_all(:,end)==1),:);%����ֻ�������������
    index_pos = find(train_all(:,end)==1);%���ɴ����������λ��index��������
    index_neg = find(train_all(:,end)==0);
        
    mat_all = Cal_mat(train_all(:,1:end-1)');
    mat_pos = mat_all(index_pos,index_pos);%��ȡ�����������������ľ����
    mat_related = mat_all(index_pos,index_neg);%��ȡ������������и���ľ����
    
    vec_candi = min(mat_pos,[],2);%�ҳ���ÿ��������������������������õ�����֮��ľ�������������
   
    mat_related = repmat(vec_candi,1,length(index_neg)) - mat_related;
    mat_related(find(mat_related>=0)) = 1;%���������ĵ�
    mat_related(find(mat_related<0)) = 0;%����ȵ�һ�������Զ�ĸ����
    
    vec_k = sum(mat_related,2);%ÿ�������kֵ����ÿ�����������ڴ��ڵĸ������Ŀ
    vec_f = (vec_k - ones(length(vec_k),1)) ./ (vec_k + ones(length(vec_k),1));%������
    vec_p = zeros(length(vec_k),1);
    
    for i = 1:length(vec_k)
       vec_p(i) = Cal_threshold(z,vec_k(i),vec_f(i));
    end
    index_final = index_pos(find(vec_p<=delta),1);%��������PPI��������index
    r_final = vec_candi(find(vec_p<=delta),1);%��������PPI�������İ뾶ȡֵ
    train_radius = zeros(size(train_all,1),1);
    train_radius(index_final,1) = r_final;
    train_all_new = [train_all,train_radius];%�����ɵ�ѵ�����������һ��
    
end


function [mat_res] = Cal_mat(X)
    n = size(X,2);%��������
    A=diag(X'*X);
    B=A';
    C =A*ones(1,n) + ones(n,1)*B - 2.*(X'*X);
    C = sqrt(C);
    mat_res = max(max(C))*eye(size(X,2)) + C;%���Լ����Լ�����ľ�������Ϊ��󣬲�������㡣
end