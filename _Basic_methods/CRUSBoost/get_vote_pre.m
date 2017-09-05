function [winner] = get_vote_pre(candi_vec,fea_vec,c)

% candi_vec:��ѡ���������ʺ�label={1,2,3....}
% fea_vec��Ȩ��������
% c:������
% winner:����������Ʊ��ͳ�ƺ�����Ԥ������

box_vec = zeros(c,1);

for i = 1:length(candi_vec)
    box_vec(candi_vec(i)) = box_vec(candi_vec(i)) + fea_vec(i);
end%for_i

candi_winner = find(box_vec == max(box_vec));
if length(candi_winner) > 1 % �ҳ���Ʊ�������Ǹ��࣬�����Ψһ���޷��жϵ�������һ��
    winner = 0;
else
    winner = candi_winner;
end%if

end%function