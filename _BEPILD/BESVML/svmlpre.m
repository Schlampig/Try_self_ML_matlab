function [vec_pre] = svmlpre(X, mat_sv, vec_alpha, b)

% ����ѵ���õ�֧�������������ؾ࣬Ԥ��X���ŵĺ���
% X����label�ľ���һ��һ������,NxD
% mat_sv�� ֧����������һ��һ������������ά��, vxD
% vec_alpha��֧������Ȩ�ئ���һ��������,vx1
% b�� �ؾ࣬һ������
% vec_pre��һ��Ԥ��������ÿ��Ԫ���Ƕ�X��Ӧ����label��Ԥ�⣬һ��Ԥ���ǣ� one_pre = sum(alpha*k(vc*x))+b

vec_b = b * ones(1,size(X,1)); % vec_b in 1xN 
% vec_tempor = sum( (repmat(vec_alpha,1,size(mat_sv,2)) .* mat_sv ) *X' ) + vec_b;
vec_tempor = - vec_alpha' * mat_sv  * X' + vec_b;
vec_pre = vec_tempor';  

end%function