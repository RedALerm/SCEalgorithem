

function [Result] = AMr(time,C,W,cc,R)

    % time = 5;          %�ظ�ʵ��30��
    % load('cifar1000_data.mat'); 

    %% ���ò���
    m = 1000;                   %�����������
    %r = round(10^1);
    r = m;
    k = 10;
    index = randsample(m,r,true);
    C = C(:,:,index);
    W = W(:,index);
    W(:,:) = 1;
    W_new = zeros(10,time);
    %center = center(:,:,index);
    center_new = zeros(10,10000,time);

    %��¼����ʱ��;���
    t1 = zeros(1,time);
    t2 = zeros(1,time);
    distance = zeros(1,time);


    %% SCE�㷨

    %R�ǳ����ı��������룬ȡֵ��ΧΪ0��1֮��
    %R=1;

    alg=1;
    for i=1:time
        t1(i) = cputime;    
        [W_new(:,i),center_new(:,:,i)] = DWB2(k,C,W,alg,R); 
        t2(i) = cputime-t1(i);
    end


    %% ��ground truth�ȽϽ��
    WA = W_new(:,1)';
    WB = W_new(:,1)';
    for i=1:time
        distance(i) = Sinkhorn(cc',center_new(:,:,i)',WA,WB);  %sinkhorn
    end


    %% �����������������ݽ���Ƚ�
    s = zeros(1,1000);
    ss = zeros(1,time);
    for i=1:time
        WA = W_new(:,1)';
        WB = W_new(:,1)';
        for j = 1:r
            s(j) = Sinkhorn(center_new(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
        end
        ss(i) = sum(s)/r;
    end


    %% ���չʾ
    
    Result = zeros(6,1);
    Result(1) = mean(t2);               %�ظ�time�ε�����ʱ���ƽ��ֵ
    Result(2) = std(t2);                %�ظ�time�ε�����ʱ�䷽��
    Result(3) = mean(distance);         %�ظ�time�ε�����ʵ���Wasserstein����ƽ��ֵ
    Result(4) = std(distance);          %�ظ�time�ε�����ʵ���Wasserstein���뷽��
    Result(5) = mean(ss);               %�ظ�time�ε�SCEĿ�꺯��ֵ��ƽ�����
    Result(6) = std(ss);                %�ظ�time�ε�SCEĿ�꺯��ֵ�ķ���
    
    X = ['AM-',num2str(R),':'];
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