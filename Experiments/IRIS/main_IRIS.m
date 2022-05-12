

function [] = main_IRIS()

    time = 5;
    load('iris1000_data.mat');
    
    
    %% 记录结果
    Result = zeros(6,6);
    %每一行分别对应
    %运行时间均值；运行时间方差；真实解Wasserstein距离均值；真实解Wasserstein距离方差；SCE目标函数值均值；SCE目标函数值方差
    %每一列分别对应
    %AM-0.1; AM-0.3; AM-0.5; AM-1 ; BGP ;Furthest
    
    
    %% 实验运行
    Result(:,1) = AMr(time,C,W,cc,0.1);
    Result(:,2) = AMr(time,C,W,cc,0.3);
    Result(:,3) = AMr(time,C,W,cc,0.5);
    Result(:,4) = AMr(time,C,W,cc,1);
    Result(:,5) = BGP(time,C,cc);
    Result(:,6) = FUR(time,C,cc);
    
    X = '【最终结果】：';
    disp(X)
    disp(Result);
    
end
