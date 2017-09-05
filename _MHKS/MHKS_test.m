function [Group] = MHKS_test(MHKSStruct,test_data_final,label_one,label_two)

%���ڲ���MHKS�Ĵ���
%MHKSStruct���������ڵ�ǰ���Ե�ѵ�����ݵĽṹ��
%test_data_final���������ݼ�


for p_test = 1:size(test_data_final,1)
    class_tag = MHKSStruct.w'*test_data_final(p_test,:)'+ MHKSStruct.b;
    if class_tag >= 0
        Group(p_test) = label_one;
    else
        Group(p_test) = label_two;
    end%end_if
end%end_for_p_test

Group = Group';