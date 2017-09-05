function [group] = kNN_test(train_all,test_all,k)

%���ڲ����㷨������group�ǲ������ż���

group = [];
train_label = train_all(:,end);

for i_test = 1:size(test_all,1)
    %���㵱ǰ��������������ѵ��������ŷ�Ͼ���
    temp = repmat(test_all(i_test,1:end-1),size(train_all,1),1) - train_all(:,1:end-1);
    vec_temp = sqrt(sum(temp.^2,2));
    
    
    %ͳ�Ƴ�����    
    [~,index1] = sort(vec_temp);
    [~,index2] = sort(index1);%����������
    vec_candidate = (train_label(find(index2<=k)))';%��ѡ����������һ������ת��Ϊ����������Ϊhist����������ʱlabel��rank���б�ʾ��䶯
    if k ~=1%����k����ͳ��ÿһ����ڸ���
        [j_rank,j_label] = hist(vec_candidate, unique(vec_candidate));%ͳ�Ƴ�������ֵ
        y = [j_label',j_rank']; 
        z = sortrows(y,-2);%���ճ��ִ������������򣬴����ٵĳ��ף�����Ӹ���,��ͶƱ�������ж�Ϊ��ǰ�ֿ������ڵ���
    else
        z(1,1) = vec_candidate;%����ڲ�������ɢ�ֲ���ͶƱ
    end%if
    
    test_label = z(1,1);   
    group = [group;test_label];
    
    clear temp;clear vec_temp;
    clear index1;clear index2;clear j_label;clear j_rank;
    clear vec_candidate;clear test_label;clear z;
end%for_i_test

end%function