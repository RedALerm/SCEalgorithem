

function [Result] = ORIGINAL(time,cycle,alg)
    
    t_high = zeros(time,1);
    distance_high = zeros(time,1);
    
    %% 实验运行
    if (alg == 1)                           %原空间直接聚类
        for i = 1:time
            [t_high(i),distance_high(i)] = High_dim_result();
        end
        AVRtime_high = mean(t_high);        %重复time次的平均高维空间运行时间
        STDtime_high = std(t_high);         %重复time次的高维空间运行时间标准差
    
        AVRdis_high = mean(distance_high);  %重复time次的平均高维空间结果距离
        STDdis_high = std(distance_high);   %重复time次的高维空间结果距离标准差
        
    elseif (alg == 2)                       %原空间聚类集成
        for i = 1:time
            [t_high(i),distance_high(i)] = High_dim_result_ensemble(cycle);
        end
        AVRtime_high = mean(t_high);        %重复time次的平均高维空间运行时间
        STDtime_high = std(t_high);         %重复time次的高维空间运行时间标准差
    
        AVRdis_high = mean(distance_high);  %重复time次的平均高维空间结果距离
        STDdis_high = std(distance_high);   %重复time次的高维空间结果距离标准差
    end    
    
    %% 结果展示
    
    Result = zeros(4,1);
    Result(1) = AVRtime_high;               %直接运行 / 重复time次的运行时间的平均值
    Result(2) = STDtime_high;               %直接运行 / 重复time次的运行时间方差
    Result(3) = AVRdis_high;                %直接运行 / 重复time次的与真实解的Wasserstein距离平均值
    Result(4) = STDdis_high;                %直接运行 / 重复time次的与真实解的Wasserstein距离方差
    
    
    if (alg == 1)
        X = 'High Dimension Result:';
        disp(X)
    elseif ( alg == 2)
        X = 'High Dimension Ensemble Result:';
        disp(X)
    end
    X = ['运行时间均值：',num2str(AVRtime_high)];
    disp(X)
    X = ['运行时间方差：',num2str(STDtime_high)];
    disp(X)
    X = ['真实解Wasserstein距离均值：',num2str(AVRdis_high)];
    disp(X)
    X = ['真实解Wasserstein距离方差：',num2str(STDdis_high)];
    disp(X)

    % t_high = t_high'
    % distance_high = distance_high'

end