function [dp] = dp_Gernerate(dp_index,label)

%��������label�ĺ���

Npos = length(find(label==1));%ѵ������������ĸ���
Nneg = length(find(label==0));%ѵ�������и���ĸ���
Nall = Npos + Nneg;%ѵ����������

if dp_index == 1%��1ΪȨ�أ�+1�����࣬-1�Ǹ���
    dp = [ones(Npos,1);-ones(Nneg,1)];
elseif dp_index == 2%N/Npos�����࣬N/Nneg�Ǹ���
    dp = [(Nall/Npos)*ones(Npos,1); -(Nall/Nneg)*ones(Nneg,1)];
end

end