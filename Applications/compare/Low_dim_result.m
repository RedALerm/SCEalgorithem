
function [t_low,distance_low,distance_avr] = Low_dim_result(cycle,rate,dim_method)


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

%% 降维后进行cycle次聚类后集成得到结果，存储在Low_ans中

    t0 = cputime;       % 降维方法计时

% %投影次数
%     cycle = 20;         % 目标得到低维空间中cycle个聚类结果  !!可调参数1
% %投影维度
%     rate = 0.05;        % 指要降低的维度是原维度的rate       !!可调参数2
% %降维方法：1->JL；2->FS；3->PCA
%     dim_method = 1;

    Low_ans = zeros(k,n,cycle);
    W0 = zeros(k,cycle);
    

    for i = 1:cycle
        [~,Low_ans(:,:,i),W0(:,i)] = Dim_Reduction_Method(data,k,rate,dim_method);
    end

%% 把cycle次结果Low_ans同groundtruth计算EMD距离

    alg = 1;            % 方法指数
    R = 1;              % DWB2方法的抽样百分比 可以调参对比试验
    [W_low,center_low] = DWB2(k,Low_ans,W0,alg,R);
    t_low = cputime-t0; % 降维方法的总用时为 t_low

    ss = Low_ans(:,:,1);
    
% 结果同groundtruth比较
    distance_low = Sinkhorn(center_low',groundtruth',W_low(:,1)',W_low(:,1)');      % 降维方法同结果的EMD距离
% 查看每次低维聚类的平均EMD距离
    emd_ans = zeros(cycle,1);
    for i = 1:cycle
        emd_ans(i) = Sinkhorn(Low_ans(:,:,i)',groundtruth',W0(:,i)',W0(:,i)');
    end
    distance_avr = mean(emd_ans);


%% 实验结果输出查看

% 时间的对比
    X = ['降维-聚类-集成方法（低维）总用时：',num2str(t_low)];
    disp(X)             % 降维-聚类-集成方法的时间

% 同结果的EMD距离的对比
    X = ['降维-聚类-集成方法（低维）的EMD距离误差：',num2str(distance_low)];
    disp(X)             % 降维-聚类-集成方法的误差
    X = ['降维-聚类-集成方法（低维）中每次低维聚类的平均EMD距离误差：',num2str(distance_avr)];
    disp(X)
    

end
