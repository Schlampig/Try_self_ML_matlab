function [fea_cell, n_fea] = fea_partition(data_cell, par)

% �����ݰ������ֿ�ĺ���
% data_cell:һ��1*n_cell�İ��壬ÿ��cell���sub���ݼ�(����)
% fea_cell��һ��n_cell��n_fea�еİ��壬ÿ��cell���sub���ݼ�(����)
% n_fea�������ֳɶ��ٿ�

n_cell = size(data_cell,2);

for i_fea = 1:n_cell
    data_temp = data_cell{1,i_fea};
    [fea_cell_temp, n_fea] = fea_idea(data_temp, par);
    for i_cell = 1:n_fea
        fea_cell{i_fea,i_cell} = fea_cell_temp{1,i_cell};
    end%for_i_cell
    clear i_cell;    
end%i_fea

end % function

%������������������������������������������������������������������������������������������������������������%

function [f_cell, n_fea] = fea_idea(data_now, par)

% data_now:һ���������ݼ�����һ��һ�����������һ����label
% fea_cell:һ��1*n_feaά�İ��壬��Ÿ����ֿ�
% n_fea��ԭʼ�����ķֿ���

% % 01:����ԭ���������ֽ�
% n_fea = 1;
% f_cell{1,1} = data_now;

% %02���ʺ�XS1/XS2�ķֽ�
% n_fea = 7;
% data = data_now(:,1:end-1); %��ȡ�����ݲ���
% label = data_now(:,end); %��ȡ������ǲ���
% f_cell{1,1} = [data(:,1),label]; % age
% f_cell{1,2} = [data(:,2),label]; % MB
% f_cell{1,3} = [data(:,3),label]; % gender
% f_cell{1,4} = [data(:,4:13),label]; % diagnose
% f_cell{1,5} = [data(:,14:1235),label]; % idcd10
% f_cell{1,6} = [data(:,1236:1246),label]; % drug
% f_cell{1,7} = [data(:,1247:end-1),label]; % exam

% % 03: ����ģʽ
% dim = size(data_now(:,1:end-1),2);
% fea = data_now(:,1:end-1);
% gnd = data_now(:,end);
% 
% if ((par.step > dim) || (par.window > dim))
%     par.step = 1;
%     par.window = 1;
% end%if
% 
% r = 1;
% for i_d = 1:par.step:dim-par.window+1
%     f_cell{1,r} = [fea(:, i_d:(i_d+par.window)),gnd];
%     r = r + 1;
% end%i_d
% n_fea = size(f_cell,2);

% 04:ȥ����ģʽ
dim = size(data_now(:,1:end-1),2);
fea = data_now(:,1:end-1);
gnd = data_now(:,end);

f_cell{1,1} = [fea(:,2:dim), gnd];
r = 2;
for i_d = 2:dim-1
    f_cell{1,r} = [fea(:,[1:i_d-1,i_d+1:dim]), gnd];
    r = r + 1;
end%for_i_d
f_cell{1,dim} = [fea(:,1:end-1), gnd];
f_cell{1,dim+1} = data_now; % ȫ������
n_fea = size(f_cell,2);

% %06���ʺ�XS1/XS2�ķֽ�
% n_fea = 5;
% data = data_now(:,1:end-1); %��ȡ�����ݲ���
% label = data_now(:,end); %��ȡ������ǲ���
% f_cell{1,1} = [data(:,1:end-1),label]; % all
% f_cell{1,2} = [data(:,[1:13,158:end-1]),label]; % no cell 02
% f_cell{1,3} = [data(:,[1:157,169:end-1]),label]; % no cell 03
% f_cell{1,4} = [data(:,1:168),label]; % no cell 04
% f_cell{1,5} = [data(:,[3:12,14:end-1]),label]; % no age, gender & MB

end%function