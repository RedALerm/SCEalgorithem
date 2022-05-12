

function [] = main_rate()
    
    time = 30;           %重复实验次数
    rate = 0.05:0.05:0.25;
    
    %% 记录结果
    Result = zeros(4,5,5);
    %每一行分别对应
    %运行时间均值；运行时间方差；真实解Wasserstein距离均值；真实解Wasserstein距离方差
    %每一列分别对应
    %不同的基本聚类个数(cycle)
    %每一页分别对应
    % 1 原空间直接聚类; 
    % 2 JL变换降维后聚类集成;
    % 3 PCA变换降维后聚类集成;
    % 4 JL变换降维后每个单次聚类结果同真实结果的 Wasserstein 距离差距平均值;
    % 5 PCA变换降维后每个单次聚类结果同真实结果的 Wasserstein 距离差距平均值；
    
    for i = 1:5
        Result(:,i,1) = ORIGINAL(time,5,1);
        [Result(:,i,2),Result(:,i,4)] = ACCELERATE(time,5,rate(i),1);
        [Result(:,i,3),Result(:,i,5)] = ACCELERATE(time,5,rate(i),3);
    end

    X = '【最终结果】：';
    disp(X)
    for i = 1:5
        disp( Result(:,:,i) );
    end
    
end