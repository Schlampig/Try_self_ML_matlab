function SMOTE_PILD_wrap

%��������SMOTE_PILD_main��������Ҫ����������ĺ�����
%ע�������smote�����������ı�����������ksmote(ʹ��smote�Ľ�����)��
%smoteĬ��Ϊ2����ksmoteĬ��Ϊ3��
%ע�⣬ѡ�õ�ԭʼ���ݼ��Ĳ�ƽ����Ӧ������smoteֵ(��main������������)��

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 60;
ktimes = 5;
dp = 2;
beta = 2;

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_beta = 1:length(beta)
        	SMOTE_PILD_main(index(i_index),ktimes,dp(i_dp),beta(i_beta));
        end%for_i_smote
    end%for_i_dp
end%for_i_index

end