

function [] = main()
    
    time = 2;           %重复实验次数
    rate = 0.05;
    cycle = 5;
    
    %% 记录结果
    t = zeros(3,4);                 %运行时间
    % 每一行分别对应
    % 1 原空间；2 JL降维；3 PCA降维
    % 每一列分别对应
    % 1 浮动区间0-0.1 & 扰动概率10%; 2 浮动区间0-0.1 & 扰动概率30%; 3 浮动区间0-0.3 &
    % 扰动概率10%; 4 浮动区间0-0.3 & 扰动概率30%;
    dis = zeros(5,4);
    % 每一行分别对应
    % 1 原空间; 2 JL降维集成结果; 3 JL降维单次平均; 4 PCA降维集成结果; 5 PCA降维单次平均
    % 每一列分别对应
    % 1 浮动区间0-0.1 & 扰动概率10%; 2 浮动区间0-0.1 & 扰动概率30%; 3 浮动区间0-0.3 &
    % 扰动概率10%; 4 浮动区间0-0.3 & 扰动概率30%;
    
    
    %% 实验运行
    % disturb 为噪声扰动区间
    % pro 为每个元素受噪声扰动概率
    disturb = [0.1,0.1,0.3,0.3];
    pro = [0.1,0.3,0.1,0.3];
    
    for j = 1:4
        [t(1,j),dis(1,j)] = ORIGINAL(time,disturb(j),pro(j));
        [t(2,j),dis(2,j),dis(3,j)] = ACCELERATE(time,cycle,rate,disturb(j),pro(j),1);
        [t(3,j),dis(4,j),dis(5,j)] = ACCELERATE(time,cycle,rate,disturb(j),pro(j),3);
    end

    X = '【最终结果】：';
    disp(X)
    X = '运行时间：';
    disp(X)
    disp(t)
    X = 'Wasserstein距离：';
    disp(X)
    disp(dis)
    
end