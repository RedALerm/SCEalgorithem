
function [t_high,distance_high] = High_dim_result_ensemble(cycle)

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


%% ����cycle�ξ���󼯳ɵõ�������洢��Low_ans��

    t0 = cputime;       % ��ά������ʱ

% %ͶӰ����
%     cycle = 20;         % Ŀ��õ���ά�ռ���cycle��������  !!�ɵ�����1
% %ͶӰά��
%     rate = 0.05;        % ָҪ���͵�ά����ԭά�ȵ�rate       !!�ɵ�����2
% %��ά������1->JL��2->FS��3->PCA
%     dim_method = 1;

    High_ans = zeros(k,n,cycle);
    W0 = zeros(k,cycle);
    

    for i = 1:cycle
        %[~,High_ans(:,:,i),W0(:,i)] = Ensemble_Method(data,k);
        %����k means�㷨
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

%% ��cycle�ν��High_ansͬgroundtruth����EMD����

    alg = 1;            % ����ָ��
    R = 1;              % DWB2�����ĳ����ٷֱ� ���Ե��ζԱ�����
    [W_low,center_high] = DWB2(k,High_ans,W0,alg,R);
    t_high = cputime-t0; % ����������ʱΪ t_low

    ss = High_ans(:,:,1);
    
% ���ͬgroundtruth�Ƚ�
    distance_high = Sinkhorn(center_high',groundtruth',W_low(:,1)',W_low(:,1)');      % ��ά����ͬ�����EMD����
% �鿴ÿ�ε�ά�����ƽ��EMD����
%     emd_ans = zeros(cycle,1);
%     for i = 1:cycle
%         emd_ans(i) = Sinkhorn(High_ans(:,:,i)',groundtruth',W0(:,i)',W0(:,i)');
%     end
%     distance_avr = mean(emd_ans);


%% ʵ��������鿴
% 
% % ʱ��ĶԱ�
%     X = ['��ά-����-���ɷ�������ά���ɣ�����ʱ��',num2str(t_high)];
%     disp(X)             % ��ά-����-���ɷ�����ʱ��
% 
% % ͬ�����EMD����ĶԱ�
%     X = ['��ά-����-���ɷ�������ά���ɣ���EMD������',num2str(distance_high)];
%     disp(X)             % ��ά-����-���ɷ��������
%     

end


