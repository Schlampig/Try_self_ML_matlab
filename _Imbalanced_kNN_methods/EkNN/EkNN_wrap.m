function EkNN_wrap

%��������EkNN_main��������Ҫ����������ĺ�����

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 1:64;
ktimes = 5;
k = [1;3];



for i_index = 1:length(index)
    for i_k = 1:length(k)
        EkNN_main(index(i_index),ktimes,k(i_k));
    end%for_i_k
end%for_i_index

end