function [b] = svmlb(X, mat_sv, vec_alpha)

% ����X�ڷ������ϣ�����õ��ؾ�b�ĺ���
% X����label�ľ���һ��һ������
% mat_sv�� ֧����������һ��һ������������ά��
% vec_alpha��֧������Ȩ�ئ���һ��������
% b�� �ؾ࣬һ������

% b_tempor = - sum( (repmat(vec_alpha,1,size(mat_sv,2)) .* mat_sv ) *X' ); % b_tempor in 1xN
b_tempor =  vec_alpha'*mat_sv * X'; % 1xN
b = b_tempor';

end %function