

function [Result] = AMr(time,C,W,cc,R)

    % time = 5;          %重复实验30次
    % load('cifar1000_data.mat'); 

    %% 设置参数
    m = 1000;                   %基本聚类个数
    %r = round(10^1);
    r = m;
    k = 10;
    index = randsample(m,r,true);
    C = C(:,:,index);
    W = W(:,index);
    W(:,:) = 1;
    W_new = zeros(10,time);
    %center = center(:,:,index);
    center_new = zeros(10,10000,time);

    %记录运行时间和距离
    t1 = zeros(1,time);
    t2 = zeros(1,time);
    distance = zeros(1,time);


    %% SCE算法

    %R是抽样的比例参数与，取值范围为0到1之间
    %R=1;

    alg=1;
    for i=1:time
        t1(i) = cputime;    
        [W_new(:,i),center_new(:,:,i)] = DWB2(k,C,W,alg,R); 
        t2(i) = cputime-t1(i);
    end


    %% 跟ground truth比较结果
    WA = W_new(:,1)';
    WB = W_new(:,1)';
    for i=1:time
        distance(i) = Sinkhorn(cc',center_new(:,:,i)',WA,WB);  %sinkhorn
    end


    %% 跟其他基本聚类数据结果比较
    s = zeros(1,1000);
    ss = zeros(1,time);
    for i=1:time
        WA = W_new(:,1)';
        WB = W_new(:,1)';
        for j = 1:r
            s(j) = Sinkhorn(center_new(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
        end
        ss(i) = sum(s)/r;
    end


    %% 结果展示
    
    Result = zeros(6,1);
    Result(1) = mean(t2);               %重复time次的运行时间的平均值
    Result(2) = std(t2);                %重复time次的运行时间方差
    Result(3) = mean(distance);         %重复time次的与真实解的Wasserstein距离平均值
    Result(4) = std(distance);          %重复time次的与真实解的Wasserstein距离方差
    Result(5) = mean(ss);               %重复time次的SCE目标函数值的平均结果
    Result(6) = std(ss);                %重复time次的SCE目标函数值的方差
    
    X = ['AM-',num2str(R),':'];
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