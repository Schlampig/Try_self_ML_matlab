function [v] = wpmat_get_v(train_binary_data,train_binary_label,InputPar,M_row,M_col,S2,I,u,b,M,D)

%������������ȡȨ������v�ĺ���
clear v;

I_phi = eye(size(M,1));%���ɹ�ϵ��λ����

for p_v = 1:size(train_binary_label)
    if p_v == 1
        A = reshape(train_binary_data(p_v,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        y = train_binary_label(p_v)*(u'*B)';
        Y = y;
        y_phi = (u'*B)';%�������ŵ��������������һ�����������
        Y_phi = y_phi;
        clear A;clear B;
    else
        A = reshape(train_binary_data(p_v,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        y = train_binary_label(p_v)*(u'*B)';
        Y = [Y,y];
        y_phi = (u'*B)';%�������ŵ��������������һ�����������
        Y_phi = [Y_phi,y_phi];
        clear A;clear B;
    end%end_if
end%end_p_v 

for i_v = 1:size(train_binary_label)-1%��pairwise����
    for j_v = i_v+1:size(train_binary_label)
        if i_v == 1 && j_v == 2
            A_i = reshape(train_binary_data(i_v,:),M_row,M_col);
            A_j = reshape(train_binary_data(j_v,:),M_row,M_col);
            B_i =[A_i zeros(size(A_i,1),1);zeros(1,size(A_i,2)) 1];
            B_j =[A_j zeros(size(A_j,1),1);zeros(1,size(A_j,2)) 1];
            y = D(i_v,j_v)*(u'*(B_i - M(i_v,j_v)*B_j))';
            Y_phi = y;
            clear A_i;clear A_j;clear B_i;clear B_j;
        else
            A_i = reshape(train_binary_data(i_v,:),M_row,M_col);
            A_j = reshape(train_binary_data(j_v,:),M_row,M_col);
            B_i =[A_i zeros(size(A_i,1),1);zeros(1,size(A_i,2)) 1];
            B_j =[A_j zeros(size(A_j,1),1);zeros(1,size(A_j,2)) 1];
            y = D(i_v,j_v)*(u'*(B_i - M(i_v,j_v)*B_j))';
            Y_phi = [Y_phi,y];
            clear A_i;clear A_j;clear B_i;clear B_j;
        end
    end%for_j_v
end%for_i_v

Y = Y';
Y_phi = Y_phi';

v = pinv(InputPar.C*S2 + Y'*Y + InputPar.lam*Y_phi'*Y_phi)*Y'*(I+b);

