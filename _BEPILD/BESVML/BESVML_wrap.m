function BESVML_wrap

%��������BESVML_main��������Ҫ����������ĺ�����

dataset_name = 'Imbalanced_data_v2.mat';
ktimes = 5; % 5FCV,fixed
% index = [3;4;6;9;11;17;18;19;21;22;23;24;31;35;37;39;41;45;49;50;53;55;59;60;61;62;64]; % for Imbalanced_data
index = [1;7;8;9]; % for Imbalanced_data_v2
C = 1;

for i_index = 1:length(index) 
    for i_C = 1:length(C)
        BESVML_main(dataset_name, index(i_index),ktimes,C(i_C));
    end%for_i_C
end%for_i_index

end