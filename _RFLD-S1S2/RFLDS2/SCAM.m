function [FMat,m_sample] = SCAM(data)

% Sample-Center Affinity Matrix������ѵ������������ѵ���������ֵ���ĵ����ƶȾ���W��������Fisher���б��㷨��
% ע��ֻ����ͬһ���������
% data:��������������ά��������������������������ͬһ��
% FMat:һ��d*d�Ĺ�ϵ����d��data��������ά��

%���ֵ����
    m_sample = mean(data);%������
    [n,d] = size(data);
    
%��FMat
    FMat = zeros(d);
    for i = 1:n
       Mat_tempor = (data(i,:) - m_sample)'* (data(i,:) - m_sample);
       FMat = FMat + Mat_tempor;
       clear Mat_tempor;  
    end