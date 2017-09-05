function SFPS_Wrap

%��������SFPS_main��������Ҫ����������ĺ�����

% ��������
dataset_name = 'KEEL';
% index = [18;20;61;62;64;69;71;73;25;26;36;48;59;66;72;74];% ѡ�����ݼ�
index = [17;19];
par.ktimes = 5; % 10 or 5 FCV,fixed
par.target = [0,0,0,1,0,0,0,0]; % 1-8�ֱ��ǣ�TPR,TNR,PPV,F1,Acc,MAcc,GMean,0.5*(Acc+MAcc)

% ��ʼ������
% SFPS����
model = 2;
ratio = [0;0.1;0.3;0.5;0.7];
n_sample = [10;25;50];
n_window = 9;
n_step = 9 ;
% classifier����
if model == 0
    C = [0.1;1;10;50;100];
%     sigma = [2^-7;2^-6;2^-5;2^-4;2^-3;2^-2;2^-1;1;2;4;8;16;32;64;128;256];
    sigma = [0.01;0.1;1;10;30;50;100];
    maxtime = 100000;
elseif model == 3
    C = [0.1;1;10;50;100];
    sigma = 1;
    maxtime = 100000;
else
    C = 1;
    sigma = 1;
    maxtime = 100000;
end%if_SVM(RBF/Linear)
if model == 1
    k = [1;3;5;7;9];
    metric = 0;
else
    k = 1;
    metric = 0;
end%if_kNN
if model == 2
    T = [5;10;20];
else
    T = 1;
end%if_RF

% ���ò��������г���
for i_index = 1:length(index)
    for i_model = 1:length(model)
        for i_ratio = 1:length(ratio)
            for i_sample = 1:length(n_sample)
               for i_window = 1:length(n_window)
                  for i_step = 1:length(n_step)
                      for i_C = 1:length(C)
                          for i_sigma = 1:length(sigma)
                              for i_k = 1:length(k)
                                  for i_metric = 1:length(metric)
                                      for i_T = 1:length(T)
                                          par.model = model(i_model);%ѡ��ģ��
                                          par.ratio = ratio(i_ratio);%���Ʋ�ƽ�����������0��1֮��
                                          par.n_sample = n_sample(i_sample);%���ݷֿ����
                                          par.window = n_window(i_window); % ����ѡ��ʱ�Ĵ��ڴ�С
                                          par.step = n_step(i_step);% ����ѡ��ʱ�Ĳ���
                                          % SVM����
                                          par.C = C(i_C);
                                          par.sigma = sigma(i_sigma);
                                          par.maxtime = maxtime;
                                          % kNN����
                                          par.k = k(i_k); 
                                          par.metric = metric(i_metric);
                                          % RF����
                                          par.T = T(i_T);

                                          %����������
                                          SFPS_main(dataset_name, index(i_index), par);
                                      end%T
                                  end%metric
                              end%k
                          end%sigma
                      end%C
                  end%step
               end%window
            end%sample
        end%ratio
    end%model
end%for_i_index

end %function