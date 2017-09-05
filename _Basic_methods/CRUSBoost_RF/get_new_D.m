function [new_D] = get_new_D( D, a, e_vec)

% AdaBoostѵ�����������·ֲ�Ȩ��D�ĺ���
% D������������ǰN��������Ȩ��
% e_vec������������ǰN����������֤������
% a����������ǰ����������Ȩ��

new_D = [];
for i = 1:length(D)
    if e_vec(i) == 0 % h(x) = f(x)
        new_D = [new_D; D(i)*exp(-a)];
    else 
        new_D = [new_D; D(i)*exp(a)];
    end%if
end%for
new_D = new_D ./ sum(new_D); % Normalization

end % function