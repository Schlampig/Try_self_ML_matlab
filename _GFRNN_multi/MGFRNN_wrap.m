function MGFRNN_wrap

%��������MGFRNN_main��������Ҫ����������ĺ�����

dataset_name = 'KEEL';
ktimes = 5; % 5FCV,fixed
index = 1:50;

for i_index = 1:length(index)
    MGFRNN_main(dataset_name, index(i_index),ktimes);
end%for_i_index

end