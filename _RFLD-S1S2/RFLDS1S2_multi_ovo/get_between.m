function [Xb,Nb] = get_between(X,w,u_pos,u_neg)

% ɸѡ�����ھ�ֵ����u_pos��u_neg֮�������
% X����������һ��һ��������NxD
% w��Ȩ��������Dx1
% u_pos�������ֵ���� 1x1
% u_neg�������ֵ���� 1x1

sample_vec = X*w; % Nx1

sample_vec(sample_vec < u_pos & sample_vec > u_neg) = -1; % �ҳ��Ǻ�ѡ������ֵΪ����������ƽ���ڵĵ㣩
% sample_vec(sample_vec > u_pos & sample_vec < u_neg) = -1; % �ҳ���ƽ����ĵ㣬Ч��������ƽ���ں�
candi_index = find(sample_vec >= 0);% ���ѡ�����±�

Xb = X(candi_index,:);
Nb = length(candi_index);

end%function