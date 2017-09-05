function kNN_multi_wrap(name)


eval(['load ',name,'_10fcv.mat']);

k = 3;


for i_k = 1:length(k)
%     dataname =  strcat('kNN_',name,'_k_',num2str(k(i_k)));%ת����ļ���
    dataname =  name;%ת����ļ���
    final_mat = [];
    for i_iter = 1:10                
        train = learn{i_iter,1};
        test = learn{i_iter,2};
        [final_res] = kNN_multi(train,test,k(i_k));
        final_mat = [final_mat,final_res];
    end%for_i_iter
    final_mat = [final_mat,mean(final_mat,2)];%�ܵľ�ֵ�������һ�С�
    save([dataname,'.mat'],'final_mat');
end%for_i_k



end%function