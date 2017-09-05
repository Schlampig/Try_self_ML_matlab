clear all;

Z = {'plot_ak_set_RFLD','plot_ak_set_BERFLD','plot_ak_set_MTRFLD'};

eval([Z{1}]); % �������ݼ�

% ��������
a_Y = {'a_Abalone19','a_WineR','a_WineW','a_Yeast1','a_Yeast3','a_Yeast4','a_Yeast5','a_Yeast6'};
k_Y = {'k_Abalone19','k_WineR','k_WineW','k_Yeast1','k_Yeast3','k_Yeast4','k_Yeast5','k_Yeast6'};
figure;

% ��a��صİ˷�ͼ
for i_a = 1:length(a_Y)
    Y = eval(a_Y{i_a});
    subplot(4,2,i_a);
    draw_one_plot(X,Y,i_a,'a');    
end%for_i_a

clear Y;
figure;
% ��k��صİ˷�ͼ
for i_k = 1:length(k_Y)
    Y = eval(k_Y{i_k});
    subplot(4,2,i_k);
    draw_one_plot(X,Y,i_k,'k');
end%for_i_k
    
