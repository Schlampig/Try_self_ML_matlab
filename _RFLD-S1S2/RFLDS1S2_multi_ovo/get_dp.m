function [dp] = get_dp(dp_index,label)

%��������label�ĺ���

Npos = length(find(label==1));%ѵ������������ĸ���
Nneg = length(find(label==0));%ѵ�������и���ĸ���
Nall = Npos + Nneg;%ѵ����������
dp = label;

if dp_index == 1%��1ΪȨ�أ�+1�����࣬-1�Ǹ���
    dp(find(label==1)) = 1;
    dp(find(label==0)) = -1;
elseif dp_index == 2%N/Npos�����࣬-N/Nneg�Ǹ���
    dp(find(label==1)) = Nall/Npos;
    dp(find(label==0)) = -(Nall/Nneg);
end

end % function