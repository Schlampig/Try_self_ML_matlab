function generate10fcv(dataname)

%addpath(genpath(pwd))

eval(['load ',dataname,'.mat']);

sample_all = [fea,gnd];
label_sum = gnd(size(gnd,1));%������
sum_class = [];

for i = 1:label_sum
    tempor_class = sample_all(find(gnd == i),1:end);
    tempor_dividedclass = randwithoutre(tempor_class); 
    sum_class = [sum_class;tempor_dividedclass];%����m��n�д�cell���������������������10��
    clear tempor_dividedclass;
end


for j1 = 1:10 %��j1��
    test = [];
    train = [];
    for k = 1:label_sum %��k��
        for j2 = 1:10 %j2�ֿ�        
            if j2 == j1
                test = [test;sum_class{k,j2}];
            else
                train = [train;sum_class{k,j2}];
            end%if           
        end        
    end    
    learn{j1,1} = train;
    learn{j1,2} = test;
end

save([dataname,'_10fcv.mat'],'learn');%ֱ�Ӵ�
    

end





