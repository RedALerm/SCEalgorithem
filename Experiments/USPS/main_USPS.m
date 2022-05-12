

function [] = main_USPS()

    time = 2;
    load('usps1000_data.mat');
    
    %% ground truth���
    cc = zeros(10,11000);
    for i = 1:10
        cc(i,(i-1)*1100+1:i*1100) = 1;
    end
    %cc����ʵ��
    
    
    %% ��¼���
    Result = zeros(6,6);
    %ÿһ�зֱ��Ӧ
    %����ʱ���ֵ������ʱ�䷽���ʵ��Wasserstein�����ֵ����ʵ��Wasserstein���뷽�SCEĿ�꺯��ֵ��ֵ��SCEĿ�꺯��ֵ����
    %ÿһ�зֱ��Ӧ
    %AM-0.1; AM-0.3; AM-0.5; AM-1 ; BGP ;Furthest
    
    
    %% ʵ������
    Result(:,1) = AMr(time,C,W,cc,0.1);
    Result(:,2) = AMr(time,C,W,cc,0.3);
    Result(:,3) = AMr(time,C,W,cc,0.5);
    Result(:,4) = AMr(time,C,W,cc,1);
    Result(:,5) = BGP(time,C,cc);
    Result(:,6) = FUR(time,C,cc);
    
    X = '�����ս������';
    disp(X)
    disp(Result);
    
end
