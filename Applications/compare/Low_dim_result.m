
function [t_low,distance_low,distance_avr] = Low_dim_result(cycle,rate,dim_method)


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

%% ��ά�����cycle�ξ���󼯳ɵõ�������洢��Low_ans��

    t0 = cputime;       % ��ά������ʱ

% %ͶӰ����
%     cycle = 20;         % Ŀ��õ���ά�ռ���cycle��������  !!�ɵ�����1
% %ͶӰά��
%     rate = 0.05;        % ָҪ���͵�ά����ԭά�ȵ�rate       !!�ɵ�����2
% %��ά������1->JL��2->FS��3->PCA
%     dim_method = 1;

    Low_ans = zeros(k,n,cycle);
    W0 = zeros(k,cycle);
    

    for i = 1:cycle
        [~,Low_ans(:,:,i),W0(:,i)] = Dim_Reduction_Method(data,k,rate,dim_method);
    end

%% ��cycle�ν��Low_ansͬgroundtruth����EMD����

    alg = 1;            % ����ָ��
    R = 1;              % DWB2�����ĳ����ٷֱ� ���Ե��ζԱ�����
    [W_low,center_low] = DWB2(k,Low_ans,W0,alg,R);
    t_low = cputime-t0; % ��ά����������ʱΪ t_low

    ss = Low_ans(:,:,1);
    
% ���ͬgroundtruth�Ƚ�
    distance_low = Sinkhorn(center_low',groundtruth',W_low(:,1)',W_low(:,1)');      % ��ά����ͬ�����EMD����
% �鿴ÿ�ε�ά�����ƽ��EMD����
    emd_ans = zeros(cycle,1);
    for i = 1:cycle
        emd_ans(i) = Sinkhorn(Low_ans(:,:,i)',groundtruth',W0(:,i)',W0(:,i)');
    end
    distance_avr = mean(emd_ans);


%% ʵ��������鿴

% ʱ��ĶԱ�
    X = ['��ά-����-���ɷ�������ά������ʱ��',num2str(t_low)];
    disp(X)             % ��ά-����-���ɷ�����ʱ��

% ͬ�����EMD����ĶԱ�
    X = ['��ά-����-���ɷ�������ά����EMD������',num2str(distance_low)];
    disp(X)             % ��ά-����-���ɷ��������
    X = ['��ά-����-���ɷ�������ά����ÿ�ε�ά�����ƽ��EMD������',num2str(distance_avr)];
    disp(X)
    

end
