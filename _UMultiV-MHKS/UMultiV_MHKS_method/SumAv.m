function [sum_av] = SumAv(universum_data,Nu,v,v0,M_row,M_col)

%����p�ӽ��µ�YvvY��YuvvuY֮��
%universum_data:��ǰ����ѵ����������������universum����
%Nu:Universum������
%v:��ǰ�����Ȩ������v
%v0:��ǰ�����ƫ�ò���
%M_row:��ǰ���󻯵�����
%M_col:��ǰ���󻯵�����

%���󻯲����
sum_av = zeros(M_row,1);
for k_sum = 1:Nu
    A = reshape(universum_data(k_sum,:),M_row,M_col);
    sum_av = sum_av + v0*A*v;
end%end_for_k_sum