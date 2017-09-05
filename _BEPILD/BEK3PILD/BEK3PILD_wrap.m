function BEK3PILD_wrap

%��������BEK3PILD_main��������Ҫ����������ĺ�����

dataset_name = 'Imbalanced_data_v2.mat';
ktimes = 5; % 5FCV,fixed
% index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64]; % for Imbalanced_data
index = [1;7;8;9]; % for Imbalanced_data_v2
dp = 2;
reg = 0;
ker_par = 100;
ker_type = 'rbf';

for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        for i_reg = 1:length(reg)
        	for i_ker = 1:length(ker_par)
        		Par.dp = dp(i_dp);
        		Par.reg = reg(i_reg);
        		Par.ker_par = ker_par(i_ker);
        		Par.ker_type = ker_type;
                BEK3PILD_main(dataset_name, index(i_index),ktimes,Par);
            end%for_i_ker
        end%for_i_reg
    end%for_i_dp
end%for_i_index

end