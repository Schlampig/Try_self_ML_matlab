function [FMat,m_sample] = SCAMc(alldata)

% Sample-Center Affinity Matrix for between-class������ѵ������������ѵ���������ֵ���ĵ����ƶȾ���W��������Fisher���б��㷨��
% ע����ͬ����ɵ�Sb��
% data:��������������ά��������������������������ͬһ��
% FMat:һ��d*d�Ĺ�ϵ����d��data��������ά��

data = alldata(:,1:end-1);%ÿһ���ƽ������
num = alldata(:,end);%ÿһ���������
%���ֵ����
    m_sample = mean(data);%������
    [n,d] = size(data);
    
%��FMat
    FMat = zeros(d);
    for i = 1:n
       Mat_tempor = (data(i,:) - m_sample)'* (data(i,:) - m_sample);
       FMat = FMat + num(n)*Mat_tempor;
    end