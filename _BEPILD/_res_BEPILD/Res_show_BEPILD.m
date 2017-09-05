%addpath(genpath(pwd))

dir_name = 'BERL';
f = dir(dir_name);
all_data = size(f,1);%��ǰ�ļ��������ļ�����



Res_AUC = [];%���f�ļ����¸����ļ��еĸ�������
Res_Gmean = [];
Res_AUCstd = [];
Res_Gmeanstd = [];
for i_data = 3:all_data % 1��2����һ�ļ��м���ǰ�ļ���·��������
    name = f(i_data,1).name;%��õ�i_data���ļ�������
    disp(name);  % ��Ļ�ϴ�ӡ���ļ�������
    D_all = dir([dir_name,'\',name,'\*']);%ָ��һ���ļ���
    num_file = size(D_all,1);%��ǰ�ļ������ļ�����   

    AUC = [];
    Gmean = [];
    AUC_std = [];
    Gmean_std = [];
    
    for i_all = 3:num_file %��ȡ����Ľ��
        load([dir_name,'\',name,'\',D_all(i_all,1).name]);
%         if i_data == all_data
%             disp([num2str(i_all - 2),' ',D_all(i_all,1).name]); % ��Ļ�ϴ�ӡ�㷨����
%         end%if
        AUC = [AUC;final_res(end-1,8)];%��ǰ���ݽ����Gmean��AUC
        Gmean = [Gmean;final_res(end-1,7)];
        AUC_std = [AUC_std;final_res(end,8)];%����AUC/Gmean�ľ������
        Gmean_std = [Gmean_std; final_res(end,7)];
    end%end_for_i_all
    
    Res_AUC = [Res_AUC,AUC];
    Res_Gmean = [Res_Gmean,Gmean];
    Res_AUCstd = [Res_AUCstd,AUC_std];
    Res_Gmeanstd = [Res_Gmeanstd,Gmean_std];

end%for_i_data

%^�������������ݼ���˳������
vec_sort = [21;15;23;17;16;12;24;10;6;5;22;7;8;28;9;13;14;4;31;11;3;2;30;25;18;29;26;27;19;20;1]; 
Res_AUC = Res_AUC(vec_sort,:);
Res_Gmean = Res_Gmean(vec_sort,:);
Res_AUCstd = Res_AUCstd(vec_sort,:);
Res_Gmeanstd = Res_Gmeanstd(vec_sort,:);

save(['All_res_',dir_name,'.mat'],'Res_AUC','Res_Gmean','Res_AUCstd','Res_Gmeanstd');


clear all;


