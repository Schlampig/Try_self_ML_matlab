function [pre_label] = get_gravity(mat_mass,vec_mass,c)


% ��������ԭ��Ժ�ѡ������Ȩ��Ԥ�����
% pre_label������ǣ�һ������
% mat_mass����һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
% vec_mass�������������ÿ����������mass
% c���������

vec_vote = [];
for i = 1:c
    temp_dist = mat_mass(find(mat_mass(:,2)==i),1);
    temp_f = vec_mass(i)*sum(1./ (temp_dist.^2)); % sum��m_c/ d^2��
    vec_vote = [vec_vote;temp_f];   
    clear temp_dist;clear temp_f;
end%for_i

temp_label = find(vec_vote == max(vec_vote)); % �ҳ��������������Ǹ���
if length(temp_label) > 1 %�޷��жϵ�������һ��
    pre_label = 0;
else
    pre_label = temp_label;
end%if

end% function