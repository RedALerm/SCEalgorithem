

function [Result] = FUR(time,C,cc)

    % time = 2;          %�ظ�ʵ��30��
    % load('cifar1000_data.mat');


    %% ���ò���

    % k = 10;
    % W(:,:) = 1;
    center_new = zeros(10,10000,time);

    %��¼����ʱ��;���
    t1 = zeros(1,time);
    t2 = zeros(1,time);
    distance = zeros(1,time);


    %% Furthest�㷨
    for i = 1:time                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        t1(i) = cputime;    
        center_new(:,:,i) = Furthest(C); 
        t2(i) = cputime-t1(i);
    end


    %% ��ground truth�ȽϽ��
    W_new = ones(10,1);
    WA = W_new(:,1)';
    WB = W_new(:,1)';
    for i = 1:time
        distance(i) = Sinkhorn(cc',center_new(:,:,i)',WA,WB);  %sinkhorn
    end


    %% �����������������ݽ���Ƚ�
    %��1000�����ݱȽ�
    s = zeros(1,1000);
    ss = zeros(1,time);
    for i=1:time
        WA = W_new(:,1)';
        WB = W_new(:,1)';
        for j = 1:1000
            s(j) = Sinkhorn(center_new(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
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
    
    X = 'Furthest:';
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
