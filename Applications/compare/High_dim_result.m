
function [t_high,distance_high] = High_dim_result()

    load('ans_kmeans.mat');
    load('groundtruth.mat');
    load('feat_apascal_train.mat');

    k = 32;
    data = full(feat');
    [n,~] = size(data);             % n�����ݵĸ���


%% ��groundtruth��ʽ����ת�� ��n*1���k*n

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
    groundtruth = cc;               % groundtruth��ʾ���ݵ���ʵ������



%% ��ά�ռ���ֱ�Ӿ���Ľ��

    t0 = cputime;       % ֱ�Ӿ��෽����ʱ
% MATLAB�Դ���kmeans������Ȼ��Խ����ʽ������������
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

    t_high = cputime-t0;% ֱ�Ӿ��෽��������ʱΪ t_low

% ���ͬgroundtruth�Ƚ�
    distance_high = Sinkhorn(High_ans',groundtruth',W_high',W_high');               % ֱ�Ӿ��෽��ͬ�����EMD����

%% ʵ��������鿴

% % ʱ��ĶԱ�
%     X = ['ֱ�Ӿ��෽������ά������ʱ��',num2str(t_high)];
%     disp(X)             % ֱ�Ӿ����ʱ��
% 
% 
% % ͬ�����EMD����ĶԱ�
%     X = ['ֱ�Ӿ��෽������ά����EMD������',num2str(distance_high)];
%     disp(X)             % ֱ�Ӿ�������

end

