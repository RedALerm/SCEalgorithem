
function [t_high,distance_high] = High_dim_result()

    load('ans_kmeans.mat');
    load('groundtruth.mat');
    load('feat_apascal_train.mat');

    k = 32;
    data = full(feat');
    [n,~] = size(data);             % n是数据的个数


%% 将groundtruth形式进行转换 从n*1变成k*n

    cc = zeros(k,n);
    for i = 1:k
        for j = 1:n
            if ( groundtruth(j) == i )
                cc(i,j) = 1;
            else
                cc(i,j) = 0;
            end
        end
    end
    groundtruth = cc;               % groundtruth表示数据的真实聚类结果



%% 高维空间中直接聚类的结果

    t0 = cputime;       % 直接聚类方法计时
% MATLAB自带的kmeans函数，然后对结果格式进行重新排列
    [idx,~] = kmeans(data,k);
    num = zeros(k,1);
    cc = zeros(k,n);
    for i = 1:k
        for j = 1:n
            if ( idx(j) == i )
                cc(i,j) = 1;
                num(i) = num(i)+1;
            else
                cc(i,j) = 0;
            end
        end
    end
    High_ans = cc;
    W_high = num/n;

    t_high = cputime-t0;% 直接聚类方法的总用时为 t_low

% 结果同groundtruth比较
    distance_high = Sinkhorn(High_ans',groundtruth',W_high',W_high');               % 直接聚类方法同结果的EMD距离

%% 实验结果输出查看

% % 时间的对比
%     X = ['直接聚类方法（高维）总用时：',num2str(t_high)];
%     disp(X)             % 直接聚类的时间
% 
% 
% % 同结果的EMD距离的对比
%     X = ['直接聚类方法（高维）的EMD距离误差：',num2str(distance_high)];
%     disp(X)             % 直接聚类的误差

end

