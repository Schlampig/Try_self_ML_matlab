function CIMatMHKS_wrap

%��������MatMHKS_main��������Ҫ����������ĺ�����

% ������ʽ��
% datanum = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20];
% ktimes = 10;
% ratio = [0.1;0.3;0.5;0.7];
% C = [0.1;1;10;0.01;100];
% attr = [2;3;4];
% u = 1;
% b = 10^(-6);

% datanum = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
datanum = 27;
ktimes = 10;
ratio = 0.1;
u = 1;
b = 10^(-6);
C = 1;
attr = [1;3;5;7;9];


for i_datanum = 1:length(datanum)
    switch datanum(i_datanum)%�������ݼ����ѡ�����ݼ�  
        case 1
            dataname_data = 'CIMat_iris';
        case 2
            dataname_data = 'CIMat_Coil20';
        case 3
            dataname_data = 'CIMat_Letter';
        case 4
            dataname_data = 'CIMat_ORL';
        case 5
            dataname_data = 'CIMat_Yale';
        case 6
            dataname_data = 'CIMat_YaleB';  
        case 7
            dataname_data = 'CIMat_breast_cancer_wisconsin';
        case 8
            dataname_data = 'CIMat_dermatology';
        case 9
            dataname_data = 'CIMat_glass_new';
        case 10
            dataname_data = 'CIMat_horse_colic';
        case 11
            dataname_data = 'CIMat_lenses';
        case 12
            dataname_data = 'CIMat_mammographic_masses';
        case 13
            dataname_data = 'CIMat_seeds_all';
        case 14
            dataname_data = 'CIMat_transfusion';
        case 15
            dataname_data = 'CIMat_VertebralColumn_all';
        case 16
            dataname_data = 'CIMat_water';
        case 17
            dataname_data = 'CIMat_wine'; 
        case 18
            dataname_data = 'CIMat_house_votes';
        case 19
            dataname_data = 'CIMat_sonar';
        case 20
            dataname_data = 'CIMat_secom'; 
        case 21
            dataname_data = 'CIMat_cmc';
        case 22
            dataname_data = 'CIMat_housing';
        case 23
            dataname_data = 'CIMat_ionosphere';
        case 24
            dataname_data = 'CIMat_pima';
        case 25
            dataname_data = 'CIMat_segment';
        case 26
            dataname_data = 'CIMat_semeion';
        case 27
            dataname_data = 'CIMat_page_blocks';   
        case 28
            dataname_data = 'CIMat_optdigits'; 
        case 29
            dataname_data = 'CIMat_pendigits'; 
        case 30
            dataname_data = 'CIMat_spambase'; 
        case 31
            dataname_data = 'CIMat_statlog'; 
        case 32
            dataname_data = 'CIMat_waveform';             
        otherwise
            disp('You have input wrong dataset number!');%���� 
    end%end_switch_dataset_kind
    for i_ratio = 1:length(ratio)
        dataname_ratio = strcat('_TrainRate_',num2str(ratio(i_ratio)));              
        for i_C = 1:length(C)
            dataname_C = strcat('_C_',num2str(C(i_C)));
                for i_attr = 1:length(attr)
                   dataname_attr = strcat('_attr_',num2str(attr(i_attr))); 
                   dataname_final = strcat(dataname_data,dataname_ratio,dataname_C,dataname_attr,'.txt');%�ϳ��ļ�ȫ��
                   CIMatMHKS_main(dataname_final,datanum(i_datanum),ktimes,ratio(i_ratio),C(i_C),attr(i_attr),u,b);
                end%for_i_attr
        end%for_i_C
    end%for_i_ratio
end%for_i_datanum



