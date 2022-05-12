
function [t_high,distance_high] = High_dim_result_ensemble(cycle)

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


%% 进行cycle次聚类后集成得到结果，存储在Low_ans中

    t0 = cputime;       % 降维方法计时

% %投影次数
%     cycle = 20;         % 目标得到低维空间中cycle个聚类结果  !!可调参数1
% %投影维度
%     rate = 0.05;        % 指要降低的维度是原维度的rate       !!可调参数2
% %降维方法：1->JL；2->FS；3->PCA
%     dim_method = 1;

    High_ans = zeros(k,n,cycle);
    W0 = zeros(k,cycle);
    

    for i = 1:cycle
        %[~,High_ans(:,:,i),W0(:,i)] = Ensemble_Method(data,k);
        %进行k means算法
        [idx,~] = kmeans(data,k);
        num = zeros(k,1);
        cc = zeros(k,n);
        for v = 1:k
            for j = 1:n
                if ( idx(j) == v )
                    cc(v,j) = 1;
                    num(v) = num(v)+1;
                else
                    cc(v,j) = 0;
                end
            end
        end
        High_ans(:,:,i) = cc;
        W0(:,i) = num/n;
    end

%% 把cycle次结果High_ans同groundtruth计算EMD距离

    alg = 1;            % 方法指数
    R = 1;              % DWB2方法的抽样百分比 可以调参对比试验
    [W_low,center_high] = DWB2(k,High_ans,W0,alg,R);
    t_high = cputime-t0; % 方法的总用时为 t_low

    ss = High_ans(:,:,1);
    
% 结果同groundtruth比较
    distance_high = Sinkhorn(center_high',groundtruth',W_low(:,1)',W_low(:,1)');      % 降维方法同结果的EMD距离
% 查看每次低维聚类的平均EMD距离
%     emd_ans = zeros(cycle,1);
%     for i = 1:cycle
%         emd_ans(i) = Sinkhorn(High_ans(:,:,i)',groundtruth',W0(:,i)',W0(:,i)');
%     end
%     distance_avr = mean(emd_ans);


%% 实验结果输出查看
% 
% % 时间的对比
%     X = ['降维-聚类-集成方法（高维集成）总用时：',num2str(t_high)];
%     disp(X)             % 降维-聚类-集成方法的时间
% 
% % 同结果的EMD距离的对比
%     X = ['降维-聚类-集成方法（高维集成）的EMD距离误差：',num2str(distance_high)];
%     disp(X)             % 降维-聚类-集成方法的误差
%     

end


