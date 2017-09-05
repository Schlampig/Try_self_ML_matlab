function [C] = constructC(W)

%����һ����������W���޼ල��������һ���ղ����C

n = size(W,1);%������������������������
C = zeros(n);%��ʼ���ղ����

for i_sample = 1:n
    vec_now = W(i_sample,:);
    for i = 1:n-1
        for j = i+1:n
            if vec_now(i)*vec_now(j) == 0
                continue;
            else%��i�͵�j�����������ڵ�i_sample�������Ľ���
                C(i,j) = C(i,j) + 1;%��ôi��j����֮��Ĺ�������ǿ1
                C(j,i) = C(j,i) + 1;
        end%for_j
    end%for_i
end%for_i_sample


end%function

