

function [Result,Result_avr] = ACCELERATE(time,cycle,rate,dim_method)
    
    t_low = zeros(time,1);
    distance_low = zeros(time,1);
    distance_avr = zeros(time,1);

    %% 实验运行
    % 投影维度
    %rate = 0.05;        % 指要降低的维度是原维度的rate       !!可调参数2
    % 降维方法：1->JL；2->FS；3->PCA
    % dim_method = 3;     % 降维方法                        !!可调参数3
    for i = 1:time
        [t_low(i),distance_low(i),distance_avr(i)] = Low_dim_result(cycle,rate,dim_method);
    end
    AVRtime_low = mean(t_low);          %重复time次的平均低维空间运行时间
    STDtime_low = std(t_low);           %重复time次的低维空间运行时间标准差

    AVRdis_low = mean(distance_low);    %重复time次的平均低维空间结果距离
    STDdis_low = std(distance_low);     %重复time次的低维空间结果距离标准差

    AVRavr_low = mean(distance_avr);    %重复time次的平均平均距离
    STDavr_low = std(distance_avr);     %重复time次的平均距离的标准差

    %% 结果展示
    
    Result = zeros(4,1);
    Result_avr = zeros(4,1);
    Result(1) = AVRtime_low;               %直接运行 / 重复time次的运行时间的平均值
    Result(2) = STDtime_low;               %直接运行 / 重复time次的运行时间方差
    Result(3) = AVRdis_low;                %直接运行 / 重复time次的与真实解的Wasserstein距离平均值
    Result(4) = STDdis_low;                %直接运行 / 重复time次的与真实解的Wasserstein距离方差
    
    Result_avr(3) = AVRavr_low;
    Result_avr(4) = STDavr_low;
    
    
    if (dim_method == 1)
        X = 'JL:';
        disp(X)
    elseif ( dim_method == 3)
        X = 'PCA:';
        disp(X)
    end
    X = ['运行时间均值：',num2str(AVRtime_low)];
    disp(X)
    X = ['运行时间方差：',num2str(STDtime_low)];
    disp(X)
    X = ['真实解Wasserstein距离均值：',num2str(AVRdis_low)];
    disp(X)
    X = ['真实解Wasserstein距离方差：',num2str(STDdis_low)];
    disp(X)
    
    % t_low = t_low'
    % distance_low = distance_low'
    % distance_avr = distance_avr';

end