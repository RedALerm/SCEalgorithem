

function [] = main_cycle()
    
    time = 30;           %�ظ�ʵ�����
    cycle = 5:5:25;
    
    %% ��¼���
    Result = zeros(4,5,6);
    %ÿһ�зֱ��Ӧ
    %����ʱ���ֵ������ʱ�䷽���ʵ��Wasserstein�����ֵ����ʵ��Wasserstein���뷽��
    %ÿһ�зֱ��Ӧ
    %��ͬ�Ļ����������(cycle)
    %ÿһҳ�ֱ��Ӧ
    % 1 ԭ�ռ�ֱ�Ӿ���; 
    % 2 ԭ�ռ���༯��;
    % 3 JL�任��ά����༯��;
    % 4 PCA�任��ά����༯��;
    % 5 JL�任��ά��ÿ�����ξ�����ͬ��ʵ����� Wasserstein ������ƽ��ֵ;
    % 6 PCA�任��ά��ÿ�����ξ�����ͬ��ʵ����� Wasserstein ������ƽ��ֵ��
    
    for i = 1:5
        Result(:,i,1) = ORIGINAL(time,cycle(i),1);
        Result(:,i,2) = ORIGINAL(time,cycle(i),2);
        [Result(:,i,3),Result(:,i,5)] = ACCELERATE(time,cycle(i),0.05,1);
        [Result(:,i,4),Result(:,i,6)] = ACCELERATE(time,cycle(i),0.05,3);
    end

    X = '�����ս������';
    disp(X)
    for i = 1:6
        disp( Result(:,:,i) );
    end
    
end