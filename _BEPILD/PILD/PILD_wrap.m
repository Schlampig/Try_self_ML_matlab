function PILD_wrap

%��������LDNN_main��������Ҫ����������ĺ�����

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 1:11;
ktimes = 5;
dp = [1;2];


for i_index = 1:length(index) 
    for i_dp = 1:length(dp)
        PILD_main(index(i_index),ktimes,dp(i_dp));
    end%for_i_dp
end%for_i_index

end