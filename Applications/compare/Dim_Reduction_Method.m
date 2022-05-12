
function [center_low,low_kmeans,W_low] = Dim_Reduction_Method(Data,k,rate,dim_method)

[n,col] = size(Data);              %行数表示输入点集的个数n,列数表示输入点集的维度d

%在低维度k中进行k means算法

%dim_method=1的情况，使用JL降维
if(dim_method == 1)
    low = round(col*rate);              %low表示要投影的低维度k,low=d*rate
    B = rand(col,low);
    R = round(B);
    f = (1/(sqrt(low))).*R;             %f即为构造的JL投影
    Q = Data*f;                         %Q是低维度k中的n个点，且每一行与Data一一对应
end

%dim_method=2的情况，使用FS降维
if(dim_method == 2)
    low = round(col*rate);              %low表示要投影的低维度k,low=d*rate
%     term = randperm(col,low);           %随机选取low列
%     Q = Data(:,term);
    Q = FeatureSelction(Data,col,k,low);%Feature Selection 函数在后面
end

%dim_method=3的情况，使用PCA降维
if(dim_method == 3)
    low = round(col*rate);              %low表示要投影的低维度k,low=d*rate
    [Q,~] = fastPCA(Data,col,k,low);
end

[idx,center_low] = kmeans(Q,k);
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
low_kmeans = cc;
W_low = num/n;
% W_low = 1/k*ones(

end


%% Featrue Selection函数
function [C] = FeatureSelction(data,colP,k,low)
    %epsilon = 0.25;
    %r = k + ceil(k/epsilon+1);
    R = normrnd(0,1,colP,low);
    Y = data*R;
    Q = orth(Y);
    T = (Q')*data;
    [U,S,V] = svd(T);
    Z = V(:,1:k);
    
    p = norm(Z,'fro')*norm(Z,'fro');            %改变;
    [n,~] = size(Z);
    possible = zeros(n,1);
    for i = 1:n
        possible(i) = norm(Z(i,:),2)*norm(Z(i,:),2)/p;
    end
    [B,I] = sort(possible);
    Omega = zeros(colP,low);
    S = zeros(low,low);
    for t = 1:low
        Omega(I(t),t) = 1;
        S(t,t) = 1/(sqrt(low*B(t)));
    end
    C = data*Omega*S;
end





function [pcaA,V] = fastPCA(data,colP,k,low)  

    epsilon = 0.25;
    r = k + ceil(k/epsilon+1);
    R = normrnd(0,1,colP,r);
    COV = data'*data;
    Y = COV*R;
    Q = orth(Y);
    T = (Q')*COV;
    [U,S,V] = svd(T);
    Z = V(:,1:low);
    %for i = 1:low
    %    Z(:,i) = Z(:,i)/norm(Z(:,i));  
    %end  
    pcaA = data*Z;

    %快速PCA  
    %输入：A--样本矩阵，每行为一个样本  
    %      k--降维至k维  
    %输出：pcaA--降维后的k维样本特征向量组成的矩阵，每行一个样本，列数 k 为降维后的样本特征维数  
    %      V--主成分向量  
    %[r,c] = size(P);    
    %meanVec = mean(P);                  %样本均值  
    %Z = (P-repmat(meanVec,r,1));        %计算协方差矩阵的转置covMatT 
    %covMatT = Z * Z';
    %[V,D] = eigs(covMatT,k);            %计算covMatT的前k个本征值和特征向量  
    %V = Z'* V;                         %得到协方差矩阵 (covMatT)' 的本征向量  
    %特征向量归一化为单位本征向量  
    %for i = 1:k  
    %    V(:,i) = V(:,i)/norm(V(:,i));  
    %end  
    %线性变换（投影）降维至k维  
    %pcaA = Z * V;  
end









