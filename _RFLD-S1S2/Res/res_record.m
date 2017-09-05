function res_record

    directory = dir;%��ǰ�ļ��еĽṹ��

    Acc_mat = [];%�������Ŀ¼���������ݽ���ľ���ÿ��һ��Ŀ¼
    AUC_mat = [];
    GM_mat = [];
    Acc_std_mat = [];
    AUC_std_mat = [];
    GM_std_mat = [];
    file_index = 3:(length(directory)-3);% ѡ��ʹ�õ��ļ�������˳��
    
    for i_file = 1:length(file_index)
               
        dir_name = [directory(file_index(i_file)).name,'\']; % ��ǰ�ļ����µĵ�i_file���ļ��е�����
        d_all = dir([dir_name,'*']);
%         data_index = 2 + [1;2;4;7;10;14;15;16;17;20;21;33;34;37;42;51;52;56;57;58;61;[64:73]'];
%         data_index = 3:length(d_all); % ѡ��ʹ�õ����ݼ�������˳��Ĭ��3��length(d_all)
        data_index = 2 + [1;56;58;[65:69]']; % ����c��kֵ�ıȽ�
        
        Acc_vec = [];%��ǰĿ¼�µ��������ݽ��������һ�����һ��
        AUC_vec = [];
        GM_vec = [];
        Acc_std_vec = [];
        AUC_std_vec = [];
        GM_std_vec = [];
           
        for i_dataset = 1:length(data_index) %�ų�1��2������Ŀ¼������ǰĿ¼��
            
            load([dir_name,d_all(data_index(i_dataset)).name]);
            if i_file == 1 % ��һ���ļ�
                disp(d_all(data_index(i_dataset)).name);
            end%if
            
            Acc_vec = [Acc_vec;final_res(end-1,end-3)];
            AUC_vec = [AUC_vec;final_res(end-1,end-2)];
            GM_vec = [GM_vec;final_res(end-1,end-1)];
            Acc_std_vec = [Acc_std_vec;final_res(end,end-3)];
            AUC_std_vec = [AUC_std_vec;final_res(end,end-2)];
            GM_std_vec = [GM_std_vec;final_res(end,end-1)];
            
        end%for_i_dataset

        Acc_mat = [Acc_mat,Acc_vec];
        AUC_mat = [AUC_mat,AUC_vec];
        GM_mat = [GM_mat,GM_vec];
        Acc_std_mat = [Acc_std_mat,Acc_std_vec];
        AUC_std_mat = [AUC_std_mat,AUC_std_vec];
        GM_std_mat = [GM_std_mat,GM_std_vec];
        
        disp(directory(file_index(i_file)).name); % ��ʾ�ļ���˳��
        
    end%for_i_file
    
    

    save('Res_BEFLD_related.mat','Acc_mat','AUC_mat','GM_mat','Acc_std_mat','AUC_std_mat','GM_std_mat')
    clear all;
    
end%function


