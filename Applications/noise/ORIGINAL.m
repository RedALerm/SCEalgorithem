

function [AVRtime_high,AVRdis_high] = ORIGINAL(time,disturb,pro)
    % time 为实验循环运行次数    
    % disturb 为噪声扰动区间
    % pro 为每个元素受噪声扰动概率

    t_high = zeros(time,1);
    distance_high = zeros(time,1);
    
    %% 实验运行
    for i = 1:time
        [t_high(i),distance_high(i)] = High_dim_result(disturb,pro);
    end
    
    
    %% 结果记录
    
    AVRtime_high = mean(t_high);        %重复time次的平均高维空间运行时间
    AVRdis_high = mean(distance_high);  %重复time次的平均高维空间结果距离
    

end