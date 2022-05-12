

function [Result] = BGP(time,C,cc)

    % time = 5;          %�ظ�ʵ��30��
    % load('cifar1000_data.mat');

    %% ���ò���

    % HBGF 
    e = [1 2 3 4 5 6 7 8 9 10];
    D = zeros(1000,10000);
    for j = 1:1000
        D(j,:) = e*C(:,:,j);
    end
    D = D';
    idxs = (1:1000);
    k = 10;
    W_new = ones(10,1);
    %center_new = zeros(10,11000,time);
    F = zeros(10,10000,time);

    %��¼����ʱ��;���
    t1 = zeros(1,time);
    t2 = zeros(1,time);
    distance = zeros(1,time);


    %% HBGF�㷨
    for i = 1:time
        t1(i) = cputime;  
        E = HBGF_spec(D,idxs,k);
        t2(i) = cputime-t1(i);
    
        for j = 1:10000
            F(E(j),j,i)=1;
        end
    end


    %% ��ground truth�ȽϽ��
    WA = W_new(:,1)';
    WB = W_new(:,1)';
    for i = 1:time
        distance(i) = Sinkhorn(cc',F(:,:,i)',WA,WB);  %sinkhorn
    end


    %% �����������������ݽ���Ƚ�
    %��1000�����ݱȽ�
    s = zeros(1,1000);
    ss = zeros(1,time);
    for i = 1:time
        WA = W_new(:,1)';
        WB = W_new(:,1)';
        for j = 1:1000
            s(j) = Sinkhorn(F(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
        end
        ss(i) = sum(s)/1000;
    end


    %% ���չʾ
    
    Result = zeros(6,1);
    Result(1) = mean(t2);               %�ظ�time�ε�����ʱ���ƽ��ֵ
    Result(2) = std(t2);                %�ظ�time�ε�����ʱ�䷽��
    Result(3) = mean(distance);         %�ظ�time�ε�����ʵ���Wasserstein����ƽ��ֵ
    Result(4) = std(distance);          %�ظ�time�ε�����ʵ���Wasserstein���뷽��
    Result(5) = mean(ss);               %�ظ�time�ε�SCEĿ�꺯��ֵ��ƽ�����
    Result(6) = std(ss);                %�ظ�time�ε�SCEĿ�꺯��ֵ�ķ���
    
    X = 'BGP:';
    disp(X)
    X = ['����ʱ���ƽ��ֵ��',num2str(Result(1))];
    disp(X)
    X = ['����ʱ��ķ��',num2str(Result(2))];
    disp(X)
    X = ['����ʵ���Wasserstein����ƽ��ֵ��',num2str(Result(3))];
    disp(X)
    X = ['����ʵ���Wasserstein���뷽�',num2str(Result(4))];
    disp(X)
    X = ['SCEĿ�꺯��ֵ��ƽ�������',num2str(Result(5))];
    disp(X)
    X = ['SCEĿ�꺯��ֵ�ķ��',num2str(Result(6))];
    disp(X)

end
