
function [center_low,low_kmeans,W_low] = Dim_Reduction_Method(Data,k,rate,dim_method)

[n,col] = size(Data);              %������ʾ����㼯�ĸ���n,������ʾ����㼯��ά��d

%�ڵ�ά��k�н���k means�㷨

%dim_method=1�������ʹ��JL��ά
if(dim_method == 1)
    low = round(col*rate);              %low��ʾҪͶӰ�ĵ�ά��k,low=d*rate
    B = rand(col,low);
    R = round(B);
    f = (1/(sqrt(low))).*R;             %f��Ϊ�����JLͶӰ
    Q = Data*f;                         %Q�ǵ�ά��k�е�n���㣬��ÿһ����Dataһһ��Ӧ
end

%dim_method=2�������ʹ��FS��ά
if(dim_method == 2)
    low = round(col*rate);              %low��ʾҪͶӰ�ĵ�ά��k,low=d*rate
%     term = randperm(col,low);           %���ѡȡlow��
%     Q = Data(:,term);
    Q = FeatureSelction(Data,col,k,low);%Feature Selection �����ں���
end

%dim_method=3�������ʹ��PCA��ά
if(dim_method == 3)
    low = round(col*rate);              %low��ʾҪͶӰ�ĵ�ά��k,low=d*rate
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


%% Featrue Selection����
function [C] = FeatureSelction(data,colP,k,low)
    %epsilon = 0.25;
    %r = k + ceil(k/epsilon+1);
    R = normrnd(0,1,colP,low);
    Y = data*R;
    Q = orth(Y);
    T = (Q')*data;
    [U,S,V] = svd(T);
    Z = V(:,1:k);
    
    p = norm(Z,'fro')*norm(Z,'fro');            %�ı�;
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

    %����PCA  
    %���룺A--��������ÿ��Ϊһ������  
    %      k--��ά��kά  
    %�����pcaA--��ά���kά��������������ɵľ���ÿ��һ������������ k Ϊ��ά�����������ά��  
    %      V--���ɷ�����  
    %[r,c] = size(P);    
    %meanVec = mean(P);                  %������ֵ  
    %Z = (P-repmat(meanVec,r,1));        %����Э��������ת��covMatT 
    %covMatT = Z * Z';
    %[V,D] = eigs(covMatT,k);            %����covMatT��ǰk������ֵ����������  
    %V = Z'* V;                         %�õ�Э������� (covMatT)' �ı�������  
    %����������һ��Ϊ��λ��������  
    %for i = 1:k  
    %    V(:,i) = V(:,i)/norm(V(:,i));  
    %end  
    %���Ա任��ͶӰ����ά��kά  
    %pcaA = Z * V;  
end









