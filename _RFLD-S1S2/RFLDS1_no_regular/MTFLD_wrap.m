function MTFLD_wrap

%��������MTFLD_main��������Ҫ����������ĺ�����

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:75;
dp = 2;
reg = 0;
theta = 2:11;%��ֵ���


for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
            for i_theta = 1:length(theta)
                MTFLD_main(dataset_name,index(i_index),ktimes,dp(i_dp),reg(i_reg),theta(i_theta));
            end%for_i_theat
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end%function