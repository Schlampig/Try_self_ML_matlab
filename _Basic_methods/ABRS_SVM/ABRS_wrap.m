function ABRS_wrap

%��������ABRS_main��������Ҫ����������ĺ�����

% ��������
dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73;25;26;36;48;59;66;72;74];% ѡ�����ݼ�
% index = [17;19;21;22;24;37;39;41;45];
index = 4;
par.ktimes = 5; % 10 or 5 FCV,fixedp;ar.Ts = 5;
par.Ts = 5;
par.Tf = 5;
par.maxtime = 50000;
Rc = [0.5;0.7;0.9];
% % Heart������
% C = [6;8;10];
% sigma = [10;50;55;60;65;100];
% KEEL������
C = [1;10;50;100;0.1];
sigma = [0.01;0.1;1;10;100];

% ���ò��������г���
for i_index = 1:length(index)
    for i_Rc = 1:length(Rc)
        for i_C = 1:length(C)
            for i_sigma = 1:length(sigma)
                par.Rc = Rc(i_Rc);
                par.C = C(i_C);
                par.sigma = sigma(i_sigma);
                ABRS_main(dataset_name, index(i_index), par);
            end%sigma
        end%C
    end%Rc
end%for_i_index

end %function