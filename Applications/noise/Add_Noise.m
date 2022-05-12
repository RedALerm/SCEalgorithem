
function [n,data] = Add_Noise(disturb,pro)
    
    load('feat_apascal_train.mat');
    data = full(feat');
    [n,col] = size(data);
    
    %参数1：噪声扰动的浮动区间
    turbulence = disturb * max(max(abs(data)));     %扰动上界为矩阵绝对值最大值的40%
    judge = -1 + 2*rand(n,col);                 %生成随机矩阵作为概率判定该位置是否受到噪音扰动
    %参数2：每个元素受到噪声扰动的概率
    % pro = 0.3;                                %受到噪声扰动的概率为40%
    for i = 1:n
        for j = 1:col
            if ( abs(judge(i,j))<=pro )
                data(i,j) = data(i,j) + judge(i,j)/pro*turbulence;
            end
        end
    end
    
end
