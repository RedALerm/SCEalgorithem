

function [Result] = BGP(time,C,cc)

    % time = 5;          %重复实验30次
    % load('iris1000_data.mat');

    %% 设置参数

    % HBGF 
    e = [1 2 3];
    D = zeros(1000,150);
    for j = 1:1000
        D(j,:) = e*C(:,:,j);
    end
    D = D';
    idxs = (1:1000);
    k = 3;
    W_new = ones(3,1);
    %center_new = zeros(3,150,time);
    F = zeros(3,150,time);

    %记录运行时间和距离
    t1 = zeros(1,time);
    t2 = zeros(1,time);
    distance = zeros(1,time);


    %% HBGF算法
    for i = 1:time
        t1(i) = cputime;  
        E = HBGF_spec(D,idxs,k);
        t2(i) = cputime-t1(i);
    
        for j = 1:150
            F(E(j),j,i)=1;
        end
    end


    %% 跟ground truth比较结果
    WA = W_new(:,1)';
    WB = W_new(:,1)';
    for i = 1:time
        distance(i) = Sinkhorn(cc',F(:,:,i)',WA,WB);  %sinkhorn
    end


    %% 跟其他基本聚类数据结果比较
    %跟1000个数据比较
    s = zeros(1,1000);
    ss = zeros(1,time);
    for i = 1:time
        WA = W_new(:,1)';
        WB = W_new(:,1)';
        for j = 1:1000
            s(j) = Sinkhorn(F(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
        end
        ss(i) = sum(s)/1000;
    end


    %% 结果展示
    
    Result = zeros(6,1);
    Result(1) = mean(t2);               %重复time次的运行时间的平均值
    Result(2) = std(t2);                %重复time次的运行时间方差
    Result(3) = mean(distance);         %重复time次的与真实解的Wasserstein距离平均值
    Result(4) = std(distance);          %重复time次的与真实解的Wasserstein距离方差
    Result(5) = mean(ss);               %重复time次的SCE目标函数值的平均结果
    Result(6) = std(ss);                %重复time次的SCE目标函数值的方差
    
    X = 'BGP:';
    disp(X)
    X = ['运行时间的平均值：',num2str(Result(1))];
    disp(X)
    X = ['运行时间的方差：',num2str(Result(2))];
    disp(X)
    X = ['与真实解的Wasserstein距离平均值：',num2str(Result(3))];
    disp(X)
    X = ['与真实解的Wasserstein距离方差：',num2str(Result(4))];
    disp(X)
    X = ['SCE目标函数值的平均结果：',num2str(Result(5))];
    disp(X)
    X = ['SCE目标函数值的方差：',num2str(Result(6))];
    disp(X)

end
