

function [AVRtime_low,AVRdis_low,AVRavr_low] = ACCELERATE(time,cycle,rate,disturb,pro,dim_method)
    % time 为实验循环运行次数
    % cycle 为基本聚类个数
    % rate 为降维幅度
    % disturb 为噪声扰动区间
    % pro 为每个元素受噪声扰动概率
    % dim_method 为降维方法：1代表JL降维; 3代表PCA降维

    t_low = zeros(time,1);
    distance_low = zeros(time,1);
    distance_avr = zeros(time,1);

    %% 实验运行
    % 投影维度
    %rate = 0.05;        % 指要降低的维度是原维度的rate       !!可调参数2
    % 降维方法：1->JL；2->FS；3->PCA
    % dim_method = 3;     % 降维方法                        !!可调参数3
    for i = 1:time
        [t_low(i),distance_low(i),distance_avr(i)] = Low_dim_result(cycle,rate,disturb,pro,dim_method);
    end

    %% 结果记录
    
    AVRtime_low = mean(t_low);          %重复time次的平均低维空间运行时间
    AVRdis_low = mean(distance_low);    %重复time次的平均低维空间结果距离
    AVRavr_low = mean(distance_avr);    %重复time次的平均平均距离
    
end