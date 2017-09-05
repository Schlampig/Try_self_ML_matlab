function WPMatMHKS_main(file_name,datanum,ktimes,ratio,C,lam,u,b,wpc)

%ע�⣺������Χ������û�б�����ơ�
%ktimes��MCCV����������1,2,3,...,10��
%ratio��ѵ�������ȣ�0.1,0.2,0.3,...,0.9��
%C:�ɳ�����1
%lam:�ɳ�����2
%u:��ʼֵ
%b:��ʼֵ
%M_row�����󻯵�����
%M_col�����󻯵�����


switch datanum %�������ݼ����ѡ�����ݼ� 
    case 1
        load iris_all.mat;
        dataname = 'iris';
    case 2
        load coil_20_all.mat;
        dataname = 'coil20';
    case 3
        load letter_all.mat;
        dataname = 'letter';
    case 4
        load orl_faces_all.mat;
        dataname = 'orl_faces';
    case 5
        load Yale_32x32_all.mat;
        dataname = 'Yale';
    case 6
        load YaleB_32x32_all.mat;
        dataname = 'YaleB';
    case 7
        load breast_cancer_wisconsin_all.mat;
        dataname = 'breast_cancer_wisconsin';
    case 8
        load dermatology_all.mat;
        dataname = 'dermatology';
    case 9
        load glass_all_new.mat;
        dataname = 'glass_new';
    case 10
        load horse_colic_all.mat;
        dataname = 'horse_colic';
    case 11
        load lenses_all.mat;
        dataname = 'lenses';
    case 12
        load mammographic_masses_all.mat;
        dataname = 'mammographic_masses';
    case 13
        load seeds_all.mat;
        dataname = 'seeds';
    case 14
        load transfusion_all.mat;
        dataname = 'transfusion';
    case 15
        load VertebralColumn_all.mat;
        dataname = 'VertebralColumn_all';
    case 16
        load water_all.mat;
        dataname = 'water';
    case 17
        load wine_all.mat;
        dataname = 'wine';
    case 18
        load house_votes_all.mat;
        dataname = 'house_votes';
    case 19
        load sonar_all.mat;
        dataname = 'sonar';
    case 20
        load secom_all.mat;
        dataname = 'secom';  
    case 21
        load cmc_all.mat;
        dataname = 'cmc';
    case 22
        load housing_all.mat;
        dataname = 'housing';
    case 23
        load ionosphere_all.mat;
        dataname = 'ionosphere';
    case 24
        load Repair_pima_all.mat;
        dataname = 'pima';
    case 25
        load segment_all.mat;
        dataname = 'segment';
    case 26
        load semeion_all.mat;
        dataname = 'semeion';
    case 27
        load page_blocks_all.mat;
        dataname = 'page_blocks';        
    otherwise
        disp('You have input wrong dataset number!');%���� 
end%end_switch_dataset_kind

% %��������ά����һ��������ȫ�֣�
% A = max(data,[],2) - min(data,[],2);
% B = repmat(min(data,[],2),1,size(data,2));
% D = repmat(A,1,size(data,2));
% data = (data-B)./D;
% clear A;clear B;clear D;

%����Ҫ�õ��Ĳ�������һ���ṹ����
InputPar.C = C;
InputPar.lam = lam;
InputPar.u = u;
InputPar.b = b;

[mat_sample_way,mat_sample_num]=Matrixlize_fun(data(:,1));%���󻯣�[�����Ժ����Ϸ�ʽ����Ϸ�ʽ�ĸ���]=������������Ŀ�ĺ���(temptvec_data)

file_id = fopen(file_name, 'w');

fprintf(file_id, 'Setting: MCCV_Time-%.1f ,Training_Ratio(Beta)-%.1f ,C-%.3f ,Lamda-%.3f , WPC-%.3f ,Dataset-%s \r\n', ktimes,ratio,C,lam,wpc,dataname);
disp(['Setting: MCCV_Time-',num2str(ktimes),', Training_Ratio(Beta)-',num2str(ratio),' ,C-',num2str(C),' ,Lamda-',num2str(lam),' ,WPC-',num2str(wpc),' ,Dataset-',dataname]);%��ӡ����Ļ��
fprintf(file_id,'--------------------------------------\r\n');%�ָ���
disp(['--------------------------------------']);
time = zeros(ktimes,1);%������¼ѵ��ʱ�������

%������ƫ��������i���ƫ�Ƽ�¼��bias_class(i)��
bias_class = zeros(length(unique(label)),1);
for i_label = 1:length(unique(label))
    i_label_tempt = find(label==unique(i_label));
    bias_class(i_label) = i_label_tempt(1);
end%for_i_label
bias_class = bias_class - 1;

sum_class = numel(unique(label));%��������

accuracy = zeros(ktimes,1);%��¼��ȷ�ȵ�����

for i_matrix = 1:mat_sample_num%��i_matrix�־��󻯽��
    M_row = mat_sample_way(i_matrix,1);%��ǰ���󻯺���������
    M_col = mat_sample_way(i_matrix,2);%��ǰ���󻯺���������
    fprintf(file_id,'The  %.1fth matrix form with the row  %.1f and the column  %.1f: \r\n',i_matrix,M_row,M_col);%��i_matrix���󻯣���ǰ�ľ���������Ϊ����
    disp(['The',num2str(i_matrix),'th matrix form with the row',num2str(M_row),'and the column',num2str(M_col),':']);
    for i_iter = 1:ktimes%��i_iter��MCCV
    %������ѵ��
    tic;%��ʼ����һ�ε�����ѵ��ʱ��
        for i_classone = 1:(sum_class-1)
            for i_classtwo = (i_classone+1):sum_class
            
                sum_classone_sample = length(find(label==i_classone));%�ҳ���ǰ������Ե�������
                sum_classtwo_sample = length(find(label==i_classtwo));          
                train_classone_sample = round(sum_classone_sample*ratio);%��������ȡ���ҳ�ѵ��������
                train_classtwo_sample = round(sum_classtwo_sample*ratio);
                bias_classone = bias_class(i_classone);%��ȡ��ǰ���ƫ����
                bias_classtwo = bias_class(i_classtwo);
              
                train_classone_data = data(:,index_struct(i_iter,i_classone).index(1:train_classone_sample)+bias_classone);%����ѵ������
                train_classtwo_data = data(:,index_struct(i_iter,i_classtwo).index(1:train_classtwo_sample)+bias_classtwo);
                train_binary_data = [train_classone_data,train_classtwo_data]';
                train_classone_label = ones(train_classone_sample,1)*i_classone;%����ѵ����������
                train_classtwo_label = ones(train_classtwo_sample,1)*i_classtwo;
                train_binary_label = [train_classone_label;train_classtwo_label];
           
                %��i_iter��MCCV��������i_classone��͵�i_classtwo�����ѵ����õ���WPMatMHKS���ݴ���PMatStruct(i_classone,i_classtwo).candidate��
                WPMatStruct(i_classone,i_classtwo).candidate = WPMatMHKS_fun(train_binary_data,train_binary_label,InputPar,M_row,M_col,wpc);%����ѵ��������u��v
            
                %���
                clear sum_classone_sample;clear sum_classtwo_sample;
                clear train_classone_sample;clear train_classtwo_sample;
                clear bias_classone;clear bias_classtwo;
                clear train_classone_data;clear train_classtwo_data;clear train_binary_data;
                clear train_classone_label;clear train_classtwo_label;clear train_binary_label;

            end%for_i_classtwo
        end%for_i_classone  
    time(ktimes) = toc;%��ktimes��MCCVѵ����ʱ
    
        %����
        %���ɲ����������ݼ�test_data�Ͷ�Ӧ������test_label
        sum_classtempt_sample = length(find(label==1));
        test_classtempt_sample = sum_classtempt_sample - round(sum_classtempt_sample*ratio);
        test_data = data(:,index_struct(i_iter,1).index((sum_classtempt_sample-test_classtempt_sample+1):sum_classtempt_sample));
        test_label = 1*ones(test_classtempt_sample,1);
        clear sum_classtempt_sample; clear test_classtempt_sample;
        for i_test = 2:sum_class
            bias_classtempt = bias_class(i_test);%��ȡ��ǰ���ƫ����
            sum_classtempt_sample = length(find(label==i_test));
            test_classtempt_sample = sum_classtempt_sample - round(sum_classtempt_sample*ratio);
            test_data = cat(2,test_data,data(:,index_struct(i_iter,i_test).index((sum_classtempt_sample-test_classtempt_sample+1):sum_classtempt_sample)+bias_classtempt));
            test_label = cat(1,test_label,i_test*ones(test_classtempt_sample,1));
        end%for_i_test
        test_data_final = (test_data)';
    
        matrix_vote = zeros(length(test_label),1);%����ͶƱ����ÿһ����һ��Group��ѡ����1������Ʊ��ͳ��
        for i_testone = 1:(sum_class-1)
            for i_testtwo = (i_testone+1):sum_class
                %���δ���������ѵ����õ����ݽ��в���          
                Group = WPMatMHKS_test(WPMatStruct(i_testone,i_testtwo).candidate,test_data_final,i_testone,i_testtwo,M_row,M_col);
                matrix_vote = cat(2,matrix_vote,Group);%�����
                clear Group;
            end%for_i_testtwo
        end%for_i_testone 

        i_candidate = (sum_class)*(sum_class-1)/2;
        for i_poll = 1:length(test_label)
            vector_vote = matrix_vote(i_poll,2:(i_candidate+1));
            matrix_vote(i_poll,1) = mode(vector_vote);
        end%for_i_poll
    
        accuracy(i_iter) = 100*(1-(length(find((test_label - matrix_vote(:,1))~=0))/length(test_label)));
    
        fprintf(file_id,'The present accuracy of %d iteration in MCCV is: %f; \r\n',i_iter,accuracy(i_iter));
        disp(['The present accuracy of ',num2str(i_iter),' iteration in MCCV is: ',num2str(accuracy(i_iter))]);%��ӡ����Ļ��
    end%for_i_iter
    fprintf(file_id,'The average accuracy is: %f; \r\n',mean(accuracy));%ktimes�־�ֵ
    disp(['The average accuracy is: ',num2str(mean(accuracy))]);%��ӡ����Ļ��
    fprintf(file_id,'The std of accuracies is: %f; \r\n',std(accuracy));%ktimes�־�����
    disp(['The std of accuracies is: ',num2str(std(accuracy))]);
    fprintf(file_id,'The average time(s) is: %f; \r\n',mean(time));%ktimes��ʱ��
    disp(['The average time(s) is: ',num2str(mean(time))]);
    fprintf(file_id,'--------------------------------------\r\n');%�ָ���
    disp(['--------------------------------------']);
    clear accuracy;clear time;
end%for_i_matrix
    
    fclose(file_id);%�ر��ļ�
    
clear;