function [pre_label] = get_final_pre(data, c)

% ���ݵ÷־���ͶƱѡ�����Ԥ��������
% data��һ��һ��model������data��Ԥ�⣬���һ�������Ŷ�Ȩ��
% c:�����

pre_label = [];
for i = 1:size(data,1)-1
    now_label = get_vote_pre(data(i,:),data(end,:),c);
    pre_label = [pre_label;now_label];
end%for_i_c

end %function