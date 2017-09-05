function [r_slice_mat, c_slice_mat] = get_slice(ts, tf, num_r, num_c, ratio_r, ratio_c)

% ��֪��Ҫ��Ƭ��(����)���ݼ�����������У����ɷ�Ƭ��ϵĺ���
% ts, tf���������������ѭ��������ts*tf�ǻ���������
% num_r, num_c�����ݼ����������������
% ratio_r, ratio_c���У����������У��������Ĳ�������,����()
% r_slice_mat, c_slice_mat��һ�д�һ����/���²����±�

sub_r = num_r*ratio_r;
sub_c = num_c*ratio_c;

r_slice_mat = [];
c_slice_mat = [];
for i = 1:ts
    for j = 1:tf
        now_r = randperm(num_r);
        r_slice_mat = [r_slice_mat;now_r(1:sub_r)];
        
        now_c = randperm(num_c);
        c_slice_mat = [c_slice_mat;now_c(1:sub_c)];
        
        clear now_r; clear now_c;
    end%for_j
end%for_i


end % function