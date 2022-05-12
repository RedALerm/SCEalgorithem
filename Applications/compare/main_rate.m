

function [] = main_rate()
    
    time = 30;           %�ظ�ʵ�����
    rate = 0.05:0.05:0.25;
    
    %% ��¼���
    Result = zeros(4,5,5);
    %ÿһ�зֱ��Ӧ
    %����ʱ���ֵ������ʱ�䷽���ʵ��Wasserstein�����ֵ����ʵ��Wasserstein���뷽��
    %ÿһ�зֱ��Ӧ
    %��ͬ�Ļ����������(cycle)
    %ÿһҳ�ֱ��Ӧ
    % 1 ԭ�ռ�ֱ�Ӿ���; 
    % 2 JL�任��ά����༯��;
    % 3 PCA�任��ά����༯��;
    % 4 JL�任��ά��ÿ�����ξ�����ͬ��ʵ����� Wasserstein ������ƽ��ֵ;
    % 5 PCA�任��ά��ÿ�����ξ�����ͬ��ʵ����� Wasserstein ������ƽ��ֵ��
    
    for i = 1:5
        Result(:,i,1) = ORIGINAL(time,5,1);
        [Result(:,i,2),Result(:,i,4)] = ACCELERATE(time,5,rate(i),1);
        [Result(:,i,3),Result(:,i,5)] = ACCELERATE(time,5,rate(i),3);
    end

    X = '�����ս������';
    disp(X)
    for i = 1:5
        disp( Result(:,:,i) );
    end
    
end